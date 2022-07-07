import 'package:flutter/material.dart';


class NewVirtualFence extends StatefulWidget {
  const NewVirtualFence({Key? key}) : super(key: key);

  @override
  State<NewVirtualFence> createState() => _NewVirtualFenceState();
}

class _NewVirtualFenceState extends State<NewVirtualFence> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'Enter home name',
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 13),
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            fillColor: Colors.transparent),
                      ))
                ],
              ),
              const Divider(
                color: Colors.black26,
                height: 20,
                thickness: 2,
                //indent: 10,
                //endIndent: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'Shape',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.circle_outlined),
                  Icon(Icons.crop_square_outlined),
                ],
              ),
              const Divider(color: Colors.black26, height: 20, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'Icon',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.home),
                  Icon(Icons.work_outlined),
                  Icon(Icons.circle_outlined),
                  Icon(Icons.crop_square_outlined),
                ],
              ),
              const Divider(color: Colors.black26, height: 20, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'Activate virtual fence',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  /*ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 1,
                    totalSwitches: 2,
                    labels: const ['True', 'False'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),*/
                ],
              ),
              const Divider(color: Colors.black26, height: 20, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: const Size(120, 60)),
                      onPressed: () {
                        _onDelete(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size(280, 60)),
                      onPressed: () {
                        _onSave(context);
                      },
                      child: const Icon(
                        Icons.gpp_good_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _onSave(BuildContext context) {

}

void _onDelete(BuildContext context) {

}
