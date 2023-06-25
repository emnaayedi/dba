import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dialogs/single_choice_dialog.dart';
import '../forms/step_list.dart';

class BasicInformationStep extends StatefulWidget {
  @override
  final Key? key;
  const BasicInformationStep({this.key}) : super(key: key);
  @override
  BasicInformationStepState createState() => BasicInformationStepState();
}

class BasicInformationStepState extends State<BasicInformationStep> {
  final TextEditingController _failureTitleController = TextEditingController();
  final TextEditingController _rigNameController = TextEditingController();
  final TextEditingController _preparedByController = TextEditingController();
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _operatorController = TextEditingController();
  final TextEditingController _contractorController = TextEditingController();
  final TextEditingController _dRNumberController = TextEditingController();
  final TextEditingController _wellNameController = TextEditingController();
  final TextEditingController _bopSurfaceController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  List<String> failureStatus = <String>[
    'Wear and Tear',
    'Manufacturing Defect',
    'OEM Design Flaw',
    'Operating Error',
    'Investigation Inconclusive',
    'Undetermined',
    'Maitenance Error'
  ];
  List<String> operations = <String>[
    'Wear and Tear',
    'Manufacturing Defect',
    'OEM Design Flaw',
    'Operating Error',
    'Investigation Inconclusive',
    'Undetermined',
    'Maitenance Error'
  ];
  late Map<String, String> failureStatusResult;
  late Map<String, String> operationsResult;
  late String failureStatusValue;
  late String operationsValue;
  String failureStatusButtonText = 'Select Failure Status';
  String operationsButtonText = 'Select Operations';
  int selectedFailureType = 0;
  int selectedPod = 0;
  DateTime failureDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    stepperData['basicInformation']?['failureDate'] = DateFormat('yyyy-MM-dd').format(DateTime.now());

  }

  Future<void> _selectFailureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Failure Date', // Can be used as title
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null && picked != failureDate) {
      setState(() {
        failureDate = picked;

        stepperData['basicInformation']?['failureDate'] = DateFormat('yyyy-MM-dd').format(picked);

      });
    }
  }
  Future <void> _selectFailureStatusOption(BuildContext context) async {
    failureStatusResult = (await    showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return SingleChoiceDialog( data: failureStatus, title:'Failure Status' ,);
      },
    ))!;

      setState(() {
        failureStatusButtonText=failureStatusResult['option']!;
        stepperData['basicInformation']?['failureStatus'] = failureStatusResult['option']!;});


  }
  Future <void> _selectOperationsOption(BuildContext context) async {
    operationsResult = (await    showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return SingleChoiceDialog( data: operations, title:'Operations' ,);
      },
    ))!;
      setState(() {
        operationsButtonText=operationsResult['option']!;
      stepperData['basicInformation']?['operations']=operationsResult['option']!;});


  }


  Widget cardButtonFailureType(String assetName, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedFailureType= index;
          stepperData['basicInformation']?['failureType'] = assetName;

        });
      },
      style: OutlinedButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(17),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          side: const BorderSide(color:  Color(0xff505050)),
          backgroundColor: (selectedFailureType == index) ? const Color(0xff505050): const Color(0xffFFFFFF)),
      child: Text(assetName,style: TextStyle(color: selectedFailureType == index ? const Color(0xffFFFFFF): const Color(0xff000000),
        fontFamily: 'RobotoRegular',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,)
      ),
    );
  }
  Widget cardButtonPod(String assetName, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedPod= index;
          stepperData['basicInformation']?['pod'] = assetName;

        });
      },
      style: OutlinedButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(17),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          side: const BorderSide(color:  Color(0xff505050)),
          backgroundColor: (selectedPod == index) ? const Color(0xff505050): const Color(0xffFFFFFF)),
      child: Text(assetName,style: TextStyle(color: selectedPod == index ? const Color(0xffFFFFFF): const Color(0xff000000),
        fontFamily: 'RobotoRegular',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Failure title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _failureTitleController,
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
                hintText: 'Enter failure title'),
            onChanged: (value) {
              stepperData['basicInformation']?['failureTitle'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Rig name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _rigNameController,
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
                hintText: 'Enter rig name'),
            onChanged: (value) {
              stepperData['basicInformation']?['rigName'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Prepared by',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _preparedByController,
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
                hintText: 'Enter preparer name'),
            onChanged: (value) {
              stepperData['basicInformation']?['preparedBy'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Equipment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _equipmentController,
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
                hintText: 'Enter equipment name'),
            onChanged: (value) {
              stepperData['basicInformation']?['equipment'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select failure type',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cardButtonFailureType('Operational Event', 0),
              ),
              Expanded(
                child: cardButtonFailureType('IBWM Event', 1),
              ),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Operator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _operatorController,
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
                hintText: 'Enter operator name'),
            onChanged: (value) {
              stepperData['basicInformation']?['operator'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failure date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
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
              backgroundColor:MaterialStateProperty.all<Color>( const Color(0xffFFFFFF)),
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
            onPressed: () => _selectFailureDate(context),
            label: Text(
              style:const TextStyle(color: Color(0xff020202)),

              ' ${DateFormat('yyyy-MM-dd').format(failureDate)}'
                ,
            ),
            icon: const Icon(Icons.date_range),

          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Contractor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _contractorController,
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
                hintText: 'Enter contractor name'),
            onChanged: (value) {
              stepperData['basicInformation']?['contractor'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'DR number',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _dRNumberController,
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
                hintText: 'Enter DR number'),
            onChanged: (value) {
              stepperData['basicInformation']?['DRNumber'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Well name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _wellNameController,
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
                hintText: 'Enter well name'),
            onChanged: (value) {
              stepperData['basicInformation']?['wellName'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failure status',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectFailureStatusOption(context);

              });
            },
            child: Text(failureStatusButtonText),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Operations',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectOperationsOption(context);

              });
            },
            child: Text(operationsButtonText),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'BOP #/Surface',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _bopSurfaceController,
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
                hintText: 'Enter BOP #/Surface'),
            onChanged: (value) {
              stepperData['basicInformation']?['bopSurface'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Event name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _eventNameController,
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
                hintText: 'Enter event name'),
            onChanged: (value) {
              stepperData['basicInformation']?['eventName'] = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select pod (if applicable)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cardButtonPod('Blue Pod', 0),
              ),
              Expanded(
                child: cardButtonPod('Yellow Pod', 1),
              ),
              Expanded(
                child: cardButtonPod('Surface', 2),
              ),

            ],
          ),
          const SizedBox(
            height: 20,
          ),

        ],

      //         ListTile(
      //           title: const Text('Operational Event'),
      //           leading: SizedBox(
      //             width:24,
      //             child: RadioListTile<SingingCharacter>(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 side: BorderSide(color: Colors.black),
      //               ),
      //               value: SingingCharacter.OperationalEvent,
      //               groupValue: _character,
      //               onChanged: (SingingCharacter? value) {
      // setState(() {
      //   _character = value;
      // });},
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           title: const Text('IBMW Event'),
      //           leading:SizedBox(
      //             width:24,
      //             child: RadioListTile<SingingCharacter>(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 side: BorderSide(color: Colors.black),
      //               ),
      //               value: SingingCharacter.IBMWEvent,
      //               groupValue: _character,
      //               onChanged: (SingingCharacter? value) {
      //   setState(() {
      //   _character = value;
      //   });
      //               },
      //             ),
      //           ),
      //         ),
    );
  }





}