import 'package:camel_tracking/screens/home_screen.dart';
import 'package:camel_tracking/screens/map_screen.dart';
import 'package:camel_tracking/screens/view_data.dart';
import 'package:camel_tracking/screens/virtual_fence/vitrual_fence_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //implementation platform('com.google.firebase:firebase-bom:30.1.0')
        primarySwatch: Colors.blue,
      ),
      home: const VirtualFenceHome(),
    );
  }
}
