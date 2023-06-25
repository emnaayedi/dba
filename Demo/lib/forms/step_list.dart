
import 'package:flutter/material.dart';

import '../FailureReportPages/attachments_step.dart';
import '../FailureReportPages/basic_information_step.dart';
import '../FailureReportPages/corrective_actions_step.dart';
import '../FailureReportPages/failure_component_data_step.dart';
import '../FailureReportPages/preview_page.dart';
import '../FailureReportPages/project_status_step.dart';
import '../db/database_helper.dart';



Map<String, Map<String, String>> stepperData = {
  'basicInformation': {
    'failureTitle': '',
    'rigName': '',
    'preparedBy': '',
    'equipment': '',
    'failureType': '',
    'operator': '',
    'failureDate': '',
    'contractor':'',
    'DRNumber':'',
    'wellName':'',
    'failureStatus':'',
    'operations':'',
    'bopSurface': '',
    'eventName': '',
    'pod': ''
  },
  'projectStatus': {
    'partDescription': '',
    'eventDescription': '',
    'indicationSymptoms': '',
    'impactedFunctions': '',
    'failureSeverity': ''
  },
  'failureComponentData': {
    'failedItemPartNo': '',
    'failedItemSerialNo': '',
    'originalInstallationDate': '',
    'cycleCountsUponFailure': '',
    'failureMode': '',
    'failureCause': '',
    'failureMechanism': '',
    'vendorOEM': '',
    'repairLocation': '',
    'discoveryMethod': '',
    'failureProgressStatus': '',

  },
  'correctiveActions': {
    'dateOfRepair': '',
    'newItemPartNo': '',
    'newItemSerialNo': '',
    'repairKitPartNo': '',
    'correctiveActionsSummary': ''
  },
  'attachments': {'attachments': ''}
};

class StepList extends StatefulWidget {
  @override
  final Key? key;
  const StepList({this.key}) : super(key: key);

  @override
  StepListState createState() => StepListState();
}

class StepListState extends State<StepList> {

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextStyle stepperTitleStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  List<Step> getSteps() {
    var items = [
      Step(
        title:  Text('Basic informtion', style: stepperTitleStyle),
        content: const BasicInformationStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Project Status', style: stepperTitleStyle),
        content: const ProjectStatusStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Failure Component Data', style: stepperTitleStyle),
        content:  const FailureComponentDataStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Corrective Action', style: stepperTitleStyle),
        content: const CorrectiveActionsStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 3 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Attachments', style: stepperTitleStyle),
        content: const AttachmentsStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 4 ? StepState.complete : StepState.disabled,
      ),
    ];
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xff020202),
        backgroundColor:  const Color(0xffFFFFFF),
        title: const Text('Create Failure Report'),
        centerTitle: true,
      ),
      body: Theme(
          data: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.orange,
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(primary: const Color(0xff878787)),
              secondaryHeaderColor: const Color(0xff878787),
              iconTheme: Theme.of(context).iconTheme.copyWith(size: 32.0)),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child:Column(
                children: [
                  Expanded(
                    child: Stepper(
                        controlsBuilder: (context, _) {
                          return Row(
                            children: <Widget>[
                              _currentStep == 4
                                  ? TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff212121)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // Set the desired border radius
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.all(
                                              10), // Set the desired padding
                                        ),
                                      ),
                                      onPressed: () =>   Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PreviewPage(
                                                  data: stepperData))),
                                      child: const Text(
                                        'GENERATE REPORT',
                                        style:
                                            TextStyle(color: Color(0xffFFFFFF)),
                                      ))
                                  : TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff212121)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // Set the desired border radius
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.all(
                                              10), // Set the desired padding
                                        ),
                                      ),
                                      onPressed: continued,
                                      child: const Text(
                                        'CONTINUE',
                                        style:
                                            TextStyle(color: Color(0xffFFFFFF)),
                                      ),
                                    ),
                              TextButton(
                                onPressed: cancel,
                                child: const Text(
                                  'PREVIOUS',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      backgroundColor: Color(0xffFFFFFF)),
                                ),
                              ),
                            ],
                          );
                        },
                        type: stepperType,
                        physics: const ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepTapped: (step) => tapped(step),
                        steps: getSteps()),
                  ),
                ],
              ),
            ),
          ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.list),
      //   onPressed: switchStepsType,
      // ),
    );
  }

  // switchStepsType() {
  //   setState(() =>
  //   stepperType == StepperType.vertical
  //       ? stepperType = StepperType.horizontal
  //       : stepperType = StepperType.vertical);
  // }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }


}
