import 'package:flutter/material.dart';

class HelpPopup extends StatelessWidget {
  String title;
  String message;
   HelpPopup({required this.title,required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}