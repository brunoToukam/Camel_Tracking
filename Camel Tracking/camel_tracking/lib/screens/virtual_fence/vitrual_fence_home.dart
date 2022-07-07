import 'package:camel_tracking/screens/virtual_fence/new_virtual_fence.dart';
import 'package:flutter/material.dart';

class VirtualFenceHome extends StatefulWidget {
  const VirtualFenceHome({Key? key}) : super(key: key);

  @override
  State<VirtualFenceHome> createState() => _VirtualFenceHomeState();
}

class _VirtualFenceHomeState extends State<VirtualFenceHome> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigator.push(
            //    context,
            //    MaterialPageRoute(
            //        builder: (context) => const NewVirtualFence()));
            _fenceEditModalBottom(context);
          },
          child: const Text('Add a new virtual Fence'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fmd_good),
              label: 'Map',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity),
              label: 'Activity',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.badge_outlined),
              label: 'Profile',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  void _fenceEditModalBottom(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return const NewVirtualFence();
        }
    );
  }
}
