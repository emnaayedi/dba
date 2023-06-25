import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../forms/step_list.dart';

class CorrectiveActionsStep extends StatefulWidget {
  @override
  final Key? key;
  const CorrectiveActionsStep({this.key}) : super(key: key);
  @override
  CorrectiveActionsStepState createState() => CorrectiveActionsStepState();
}

class CorrectiveActionsStepState extends State<CorrectiveActionsStep> {
  final TextEditingController _newItemPartNumber = TextEditingController();
  final TextEditingController _newItemSerialNumber = TextEditingController();
  final TextEditingController _repairKitPatNumber = TextEditingController();
  final TextEditingController _correctiveActionSummary =
  TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Date Of Repair', // Can be used as title
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null && picked != dateOfRepair) {
      setState(() {
        dateOfRepair = picked;
        stepperData['correctiveActions']?['dateOfRepair'] = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  late DateTime dateOfRepair = DateTime.now();

 

  @override
  Widget build(BuildContext context) {
    return  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Repair date',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  iconColor:MaterialStateProperty.all<Color>(const Color(0xff020202)),
                  backgroundColor:MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(color: Color(0xff020202)),
                      // Set the desired border radius
                    ),

                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10), // Set the desired padding
                  ),

                ),
                onPressed: () => _selectDate(context),
                label: Text(
                  style:const TextStyle(color: Color(0xff020202)),
                  ' ${DateFormat('yyyy-MM-dd').format(dateOfRepair)}'
                     ,
                ),
                icon: const Icon(Icons.date_range),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'New item part no',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _newItemPartNumber,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 2.0,
                        )),
                    hintText: 'Enter new item part number'),
                onChanged: (value) {
                  stepperData['correctiveActions']?['newItemPartNo'] = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'New item serial no',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _newItemSerialNumber,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 2.0,
                        )),
                    hintText: 'Enter new item serial number'),
                onChanged: (value) {
                  stepperData['correctiveActions']?['newItemSerialNo'] = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Repair Kit Part no',
                style:  TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _repairKitPatNumber,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff000000),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                          width: 2.0,
                        )),
                    hintText: 'Enter repair kit part number'),
                onChanged: (value) {
                  stepperData['correctiveActions']?['repairKitPartNo'] = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Corrective Actions Summary',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 100,
                child: TextField(
                  controller: _correctiveActionSummary,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff000000),
                            width: 2.0,
                          )),
                      hintText: 'Enter corrective actions'),
                  onChanged: (value) {
                    stepperData['correctiveActions']?['correctiveActionsSummary'] = value;
                  },
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,

                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]);
  }
}