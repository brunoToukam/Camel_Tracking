import 'package:camel_tracking/screens/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  const UpdateScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  final _ref = FirebaseDatabase.instance.ref().child("tasks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: "Enter updated value"),
                  validator: (value) {
                    if(value != null && value.isEmpty) {
                      return "Enter updated value";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: () {
                      if(!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      String _text = _textController.text;
                      _ref.child(widget.value).set(_text);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ViewData()));
                    },
                    child: const Text("Update"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
