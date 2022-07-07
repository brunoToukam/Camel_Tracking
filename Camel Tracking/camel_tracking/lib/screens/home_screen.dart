import 'package:camel_tracking/screens/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child("tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _taskController,
                  decoration: const InputDecoration(hintText: "Enter task"),
                  validator: (value)  {
                    if(value != null && value.isEmpty) {
                      return "Enter task";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                ElevatedButton(
                  onPressed: () {
                    if(!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    _ref.push().set(_taskController.text).then((value) =>
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const ViewData()
                        )));
                  },
                  child: const Text("Submit"))
              ],
            )
          ),
        ),
      ),
    );
  }
}
