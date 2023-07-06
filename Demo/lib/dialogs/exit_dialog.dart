import 'package:flutter/material.dart';
@immutable
class ExitDialog extends StatefulWidget {

  final String message;

   ExitDialog({required this.message});
  @override
  ExitDialogState createState() => ExitDialogState(message:this.message);
}

class ExitDialogState extends State<ExitDialog> {

  String message;

  ExitDialogState({required this.message});
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Unsaved Changes'),
      content: Container(child: Text(message)),

      actions: <Widget>[
    TextButton(
    child: const Text('CANCEL'),
    onPressed: () =>
    Navigator.of(context).pop(false)



    ),
        TextButton(
          child: const Text('DISCARD & EXIT'),
    onPressed: () =>
    Navigator.of(context).pop(true)


        ),
      ],
    );
  }
}