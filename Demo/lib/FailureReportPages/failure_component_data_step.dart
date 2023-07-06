import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dialogs/help_dialog.dart';
import '../dialogs/single_choice_dialog.dart';
import '../forms/step_list.dart';

class FailureComponentDataStep extends StatefulWidget {
  @override
  final Key? key;
  const FailureComponentDataStep({this.key}) : super(key: key);
  @override
  FailureComponentDataStepState createState() =>
      FailureComponentDataStepState();
}

class FailureComponentDataStepState extends State<FailureComponentDataStep> {
  final TextEditingController _fieldItemPartNumberController =
      TextEditingController();
  final TextEditingController _fieldItemSerialNumberController =
      TextEditingController();
  final TextEditingController _cycleCountsUponFailureController =
      TextEditingController();
  final TextEditingController _vendorOEMController = TextEditingController();

  int selectedFailureStatus = 0;
  int selectedRepairLocation = 0;

  DateTime originalInstallationDate = DateTime.now();
  List<String> failureMode = <String>[
    'Damage - No Failure',
    'Inaccurate inidication',
    'Leakage external - Major',
    'Leakage external - No',
    'Functional Impact',
    'No indiction'
  ];
  List<String> failureCause = <String>[
    'Wear and Tear',
    'Manufacturing Defect',
    'OEM Design Flaw',
    'Operating Error',
    'Investigation Inconclusive',
    'Undetermined',
    'Maitenance Error'
  ];
  List<String> failureMechanism = <String>[
    'Electrical Failure',
    'External Failure',
    'Instrument Failure',
    'Material Failure',
    'Mechanical Failure',
    'Misc'
  ];
  List<String> discoveryMethod = <String>[
    'RTM',
    'Visual Indication (incl. ROV)',
    'BOP Pressure Test',
    'BOP Function Test',
    'Soak Test',
    'Maintenance/Inspection',
    'BOP Control System & Alarms',
  ];
  String failureCauseHelpMessage = '';
  String discoveryMethodHelpMessage = '';
  String failureCauseButtonText = 'Enter failure cause';
  String failureModeButtonText = 'Enter failure mode';
  String discoveryMethodButtonText = 'Enter discovery method';
  String failureMechanismButtonText = 'Enter failure mechanism';

  late String failureModeValue;
  late String failureCauseValue;
  late String failureMechanismValue;
  late String discoveryMethodValue;
  late Map<String, String> failureCauseResult;
  late Map<String, String> failureModeResult;
  late Map<String, String> failureMechanismResult;
  late Map<String, String> discoveryMethodResult;

  @override
  void initState() {
    super.initState();
    failureModeValue = failureMode.first;
    failureCauseValue = failureCause.first;
    failureMechanismValue = failureMechanism.first;
    discoveryMethodValue = discoveryMethod.first;
    stepperData['Failure Component Data']?['Repair Location'] = 'Rig Site';
    stepperData['Failure Component Data']?['Failure Progress Status'] = 'Corrected';
    stepperData['Failure Component Data']?['Original Installation Date'] =   DateFormat('yyyy-MM-dd').format(DateTime.now());

  }

  Future<void> selectFailureCause(BuildContext context) async {
    try {
      failureCauseResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(
            data: failureCause,
            title: 'Failure Cause',
          );
        },
      ))!;

      setState(() {
        failureCauseButtonText = failureCauseResult['option']!;
        stepperData['Failure Component Data']?['Failure Cause'] =
            failureModeResult['option']!;
      });
    } catch (e) {}
  }

  Future<void> selectFailureMode(BuildContext context) async {
    try {
      failureModeResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(
            data: failureMode,
            title: 'Failure Mode',
          );
        },
      ))!;

      setState(() {
        failureModeButtonText = failureModeResult['option']!;
        stepperData['Failure Component Data']?['Failure Mode'] =
            failureModeResult['option']!;
      });
    } catch (e) {}
  }

  Future<void> selectFailureMechanism(BuildContext context) async {
    try {
      failureMechanismResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(
            data: failureMechanism,
            title: 'Failure Mechanism',
          );
        },
      ))!;

      setState(() {
        failureMechanismButtonText = failureMechanismResult['option']!;
        stepperData['Failure Component Data']?['Failure Mechanism'] =
            failureMechanismResult['option']!;
      });
    } catch (e) {}
  }

  Future<void> selectDiscoveryMethod(BuildContext context) async {
    try {
      discoveryMethodResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(
            data: discoveryMethod,
            title: 'Discovery Method',
          );
        },
      ))!;

      setState(() {
        discoveryMethodButtonText = discoveryMethodResult['option']!;
        stepperData['Failure Component Data']?['Discovery Method'] =
            discoveryMethodResult['option']!;
      });
    } catch (e) {}
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Original Installation Date', // Can be used as title
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null && picked != originalInstallationDate) {
      setState(() {
        originalInstallationDate = picked;
        stepperData['Failure Component Data']?['Original Installation Date'] =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _showHelpPopup(
      BuildContext context, String helpTitle, String helpMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HelpPopup(title: helpTitle, message: helpMessage);
      },
    );
  }

  Widget failureStatus(String assetName, int index) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            selectedFailureStatus = index;
            stepperData['Failure Component Data']?['Failure Progress Status'] =
                assetName;
          });
        },
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(17),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: const BorderSide(color: Color(0xff505050)),
            backgroundColor: (selectedFailureStatus == index)
                ? const Color(0xff505050)
                : const Color(0xffFFFFFF)),
        child: Text(assetName,
            style: TextStyle(
              color: selectedFailureStatus == index
                  ? const Color(0xffFFFFFF)
                  : const Color(0xff000000),
              fontFamily: 'RobotoRegular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.15,
            )));
  }

  Widget repairLocationCardButton(String assetName, int index) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedRepairLocation = index;
            stepperData['Failure Component Data']?['Repair Location'] = assetName;
          });
        },
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(17),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: const BorderSide(color: Color(0xff505050)),
            backgroundColor: (selectedRepairLocation == index)
                ? const Color(0xff505050)
                : const Color(0xffFFFFFF)),
        child: Text(assetName,
            style: TextStyle(
              color: selectedRepairLocation == index
                  ? const Color(0xffFFFFFF)
                  : const Color(0xff000000),
              fontFamily: 'RobotoRegular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.15,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Failed Item Part no',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),SizedBox(width:300,child:
          TextField(
            controller: _fieldItemPartNumberController,
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
                hintText: 'Enter part number'),
            onChanged: (value) {
              stepperData['Failure Component Data']?['Failed Item Part No'] = value;
            },
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failed Item Serial no',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
    SizedBox(width:300,child:
          TextField(
            controller: _fieldItemSerialNumberController,
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
                hintText: 'Enter serial number'),
            onChanged: (value) {
              stepperData['Failure Component Data']?['Failed Item Serial No'] =
                  value;
            },
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Original installation date',
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
              iconColor:
                  MaterialStateProperty.all<Color>(const Color(0xff020202)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
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
                style: const TextStyle(color: Color(0xff020202)),
                ' ${DateFormat('yyyy-MM-dd').format(originalInstallationDate)}'),
            icon: const Icon(Icons.date_range),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Cycle Counts Upon Failure',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
    SizedBox(width:400,child:
          TextField(
            controller: _cycleCountsUponFailureController,
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
                hintText: 'Enter cycle counts upon failure'),
            onChanged: (value) {
              stepperData['Failure Component Data']?['Cycle Counts Upon Failure'] =
                  value;
            },
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failure mode',
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
                selectFailureMode(context);
              });
            },
            child: IntrinsicWidth(
              child: Row(
                  children: [
                    Text(failureModeButtonText,style: TextStyle(fontSize: 18)),
                    Icon(Icons.keyboard_arrow_down)
                  ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failure cause',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectFailureCause(context);
                  });
                },
                child: Row(
                    children: [
                      Text(failureCauseButtonText,style: TextStyle(fontSize: 18)),
                      Icon(Icons.keyboard_arrow_down),
                    ]),
              ),
              InkWell(
                onTap: () {
                  _showHelpPopup(
                      context, 'Failure Cause Help', failureCauseHelpMessage);
                },
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.error_outline_outlined)),
              ),
            ],
          ),

          // DropdownButtonFormField<String>(
          //   value: failure_cause,
          //   items: failureCause.map((String option) {
          //     return DropdownMenuItem<String>(
          //       value: option,
          //       child: Text(option),
          //     );
          //   }).toList(),
          //   onChanged: (newValue) {
          //     setState(() {
          //       failure_cause = newValue!;
          //     });
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Failure mechanism',
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
                selectFailureMechanism(context);
              });
            },
            child: SizedBox(width:250,child:Row(
                children: [
                  Text(failureMechanismButtonText,style: TextStyle(fontSize: 18)),
                  Icon(Icons.keyboard_arrow_down),
                ])),
          ),
          // DropdownButtonFormField<String>(
          //   value: failureMechanismValue,
          //   items: failureMechanism.map((String option) {
          //     return DropdownMenuItem<String>(
          //       value: option,
          //       child: Text(option),
          //     );
          //   }).toList(),
          //   onChanged: (newValue) {
          //     setState(() {
          //       failureMechanismValue = newValue!;
          //     });
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Vendor/OEM',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
    SizedBox(width:300,child:
          TextField(
            controller: _vendorOEMController,
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
                hintText: 'Enter vendor / OEM'),
            onChanged: (value) {
              stepperData['Failure Component Data']?['Vendor OEM'] = value;
            },
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select repair location',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: repairLocationCardButton('Rig Site', 0),
              ),
              Expanded(
                child: repairLocationCardButton('Land Workshop', 1),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Discovery Method',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectDiscoveryMethod(context);
                  });
                },
                child: Row(

                    children: [

                      Text(discoveryMethodButtonText,style: TextStyle(fontSize: 18),),
                      Icon(Icons.keyboard_arrow_down),
                    ]),
              ),
              InkWell(
                onTap: () {
                  _showHelpPopup(context, 'Discovery Method Help',
                      discoveryMethodHelpMessage);
                },
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.error_outline_outlined)),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select failure status',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: failureStatus('Corrected', 0),
              ),
              Expanded(
                child: failureStatus('Pending', 1),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ]);
  }
}
