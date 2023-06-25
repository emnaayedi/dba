import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  final Key? key;
  const FormPage({this.key}) : super(key: key);
  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        // prevent the soft keyboard from covering the text fields
        bottom: MediaQuery.of(context).viewInsets.bottom + 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }
  // Implement the state and build method for the form page here
  // ...
}