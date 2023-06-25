import 'package:flutter/material.dart';
@immutable
class SingleChoiceDialog extends StatefulWidget {

 final List<String> data;
  final String title;

  const SingleChoiceDialog({required this.data,required this.title});
  @override
  SingleChoiceDialogState createState() => SingleChoiceDialogState(options:data,title:title);
}

class SingleChoiceDialogState extends State<SingleChoiceDialog> {
  List<String> options;
  String title;
  late String optionValue;

  SingleChoiceDialogState({required this.options,required this.title});
  @override
  void initState() {
    super.initState();
    optionValue=options.first;  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: optionValue,
            onChanged: (value) {
              setState(() {
                optionValue = value!;
              });
            },
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
setState(() {
  Navigator.pop(context,{'option':optionValue});

});

          },
        ),
      ],
    );
  }
}