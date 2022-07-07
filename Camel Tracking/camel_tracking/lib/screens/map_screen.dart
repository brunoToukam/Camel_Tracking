import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.4312970),
    zoom: 11.5
  );
  late GoogleMapController _googleMapController;

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  Set<Polyline> _polylines = Set<Polyline>();

  int _polygonIdCounter = 1;
  List<LatLng> polylineCoordinates = [];

  static const _somePosition = CameraPosition(
    bearing: 192.887737393,
    target: LatLng(37.3663829793, -122.08868363697),
    tilt: 59.0346436573,
    zoom: 19.156386387
  );

  static const Marker _sourceMarker = Marker(
    markerId: MarkerId('source'),
    infoWindow: InfoWindow(title: "Source"),
    icon: BitmapDescriptor.defaultMarker, //default is red
    position: LatLng(37.773972, -122.4312970)
  );

  static final Marker _destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: "Destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), //default is red
      position: const LatLng(37.073072, -122.0310970)
  );

  List<LatLng> polylinePoints = <LatLng>[];


  final Polyline _polyline = const Polyline(
    polylineId: PolylineId('_polyline'),
    points: [],
    width: 5,
    color: Colors.red
  );

  Set<Circle> circles = {const Circle(
    circleId: CircleId("circle"),
    center: LatLng(37.773972, -122.4312970),
    radius: 4000,
    strokeWidth: 1,
    fillColor: Colors.blueAccent,
  )};

  @override
  void initState() {
    _setMarker(const LatLng(37.773972, -122.4312970));
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        mapType: MapType.normal, //hybrid, satellite
        //myLocationButtonEnabled: false,
        //zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _controller.complete(controller), //_googleMapController = controller,
        markers: {_sourceMarker, _destinationMarker},
        polylines: _polylines,
        circles: circles,
        polygons: _polygons,
        onTap: (point) {
          setState(() {
            _setPolylines(point);
            double d = calculateDistance(point, const LatLng(37.773972, -122.4312970));
            if(d < 4) {
              print(d);
              print("*********** Point is within the cicrle");
            } else {
              print("Point is outside *****************************");
            }
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          CameraUpdate.newCameraPosition(_initialCameraPosition);
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }




  Future<void> _goSomewhere() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_somePosition));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(markerId: const MarkerId('marker'), position: point)
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs,
      strokeWidth: 2,
      fillColor: Colors.transparent
    ));
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCBP8bGpLZvlJIQmu7Z3V6f2-pRX2WKN-k",
        const PointLatLng(37.773972, -122.4312970),
        const PointLatLng(37.073072, -122.0310970));

    if(result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  void _setPolylines(LatLng point) {
    polylinePoints.add(point);
    _polylines.add(Polyline(
        polylineId: const PolylineId("polyline"),
        points: polylinePoints,
        width: 5,
        color: Colors.red
    ));
  }

  //it will return distance in Km
  double calculateDistance(LatLng point1, LatLng point2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((point2.latitude - point1.latitude) * p)/2 +
        cos(point1.latitude * p) * cos(point2.latitude * p) *
            (1 - cos((point2.longitude - point1.longitude) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  //Check if a point is in an area

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}
