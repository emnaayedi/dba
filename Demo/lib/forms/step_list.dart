
import 'package:demo/dialogs/exit_dialog.dart';
import 'package:demo/main.dart';
import 'package:flutter/material.dart';

import '../FailureReportPages/basic_information_step.dart';
import '../FailureReportPages/corrective_actions_step.dart';
import '../FailureReportPages/failure_component_data_step.dart';
import '../FailureReportPages/preview_page.dart';
import '../FailureReportPages/project_status_step.dart';
import '../db/database_helper.dart';
import '../navbars/bottom_navbar.dart';



late Map<String, Map<String, String>> stepperData={
  'Basic Information': {
    'Failure Title':'',
    'Rig Name': '',
    'Prepared By': '',
    'Equipment': '',
    'Failure Type':  '',
    'Operator':  '',
    'Failure Date': '',
    'Contractor': '',
    'DR Number': '',
    'Well Name': '',
    'Failure Status': '',
    'Operations': '',
    'BOP Surface':  '',
    'Event Name':  '',
    'Pod':  '',
  },
  'Project Status': {
    'Part Description': '',
    'Event Description': '',
    'Indication Symptoms':'',
    'Impacted Functions': '',
    'Failure Severity': ''
  },
  'Failure Component Data': {
    'Failed Item Part No':  '',
    'Failed Item Serial No':'',
    'Original Installation Date':  '',
    'Cycle Counts Upon Failure': '',
    'Failure Mode':  '',
    'Failure Cause':  '',
    'Failure Mechanism':  '',
    'Vendor OEM':  '',
    'Repair Location':  '',
    'Discovery Method':  '',
    'Failure Progress Status':  '',
  },
  'Corrective Actions': {
    'Date Of Repair':  '',
    'New Item Part No':  '',
    'New Item Serial No':  '',
    'Repair Kit Part No':  '',
    'Corrective Actions Summary':  ''
  },


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
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  List<Step> getSteps() {
    var items = [
      Step(
        title:  Text('Basic informtion', style: stepperTitleStyle),
        content: const BasicInformationStep(isUpdate: false),
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
      // Step(
      //   title: Text('Attachments', style: stepperTitleStyle),
      //   content: const AttachmentsStep(),
      //   isActive: _currentStep >= 0,
      //   state: _currentStep > 4 ? StepState.complete : StepState.disabled,
      // ),
    ];
    return items;
  }
  int _currentIndex = 0;
  bool exitResult=false;

  Future<void> _onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
    bool exit= await showExitForm(context);
    if(exit==true){
    if (index == 0) {

      // Navigate to Home Page
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Navigate to Search Page
      Navigator.pushReplacementNamed(context, '/notifications');
    } else if (index == 2) {
      // Navigate to Settings Page
      Navigator.pushReplacementNamed(context, '/failures_list');
    }}
  }
  Future<bool> showExitForm(BuildContext context) async {
    try{
    exitResult= (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return ExitDialog(message: 'This form contains unsaved changes. Do you wish to discard them?');}))!;}
    catch(e){}
    return exitResult;
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return await showExitForm(context);
    },
    child:Scaffold(
      appBar: AppBar(
          actions: [
      Padding(
        padding: EdgeInsets.all(8),
        child:          ElevatedButton.icon(
              icon:Icon(Icons.drafts_outlined),
            label: const Text('Save'),


            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),backgroundColor: Colors.white10),

            onPressed: () => addFailure()),

      )],
      // foregroundColor: const Color(0xff020202),
        // backgroundColor:  const Color(0xffFFFFFF),
        title: const Text('Create Failure Report'),
        centerTitle: true,
      ),
      body: Theme(
          data: ThemeData(
              brightness: Brightness.light,
              // primarySwatch: Colors.orange,
              // colorScheme:
              //     ColorScheme.fromSwatch().copyWith(primary: const Color(0xff878787)),
              // secondaryHeaderColor: const Color(0xff878787),
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
                              _currentStep == 3
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

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.list),
      //   onPressed: switchStepsType,
      // ),
    ));
  }

  // switchStepsType() {
  //   setState(() =>
  //   stepperType == StepperType.vertical
  //       ? stepperType = StepperType.horizontal
  //       : stepperType = StepperType.vertical);
  // }
  addFailure() async {

    await DatabaseHelper.createRig(  stepperData['Basic Information']?['Failure Title'], stepperData['Basic Information']?['Rig Name'],  stepperData['Basic Information']?['Prepared By'],
      stepperData['Basic Information']?['Equipment'],  stepperData['Basic Information']?['Failure Type'],  stepperData['Basic Information']?['Operator'],
      stepperData['Basic Information']?['Failure Date'],  stepperData['Basic Information']?['Contractor'],
      stepperData['Basic Information']?['DR Number'],  stepperData['Basic Information']?['Well Name'],  stepperData['Basic Information']?['Failure Status'],  stepperData['Basic Information']?['Operations'], stepperData['Basic Information']?['BOP Surface'], stepperData['Basic Information']?['Event Name'],
      stepperData['Basic Information']?['Pod'],  stepperData['Project Status']?['Part Description'], stepperData['Project Status']?['Event Description'],stepperData['Project Status']?['Indication Symptoms'], stepperData['Project Status']?['Impacted Functions'],
      stepperData['Project Status']?['Failure Severity'],
      stepperData['Failure Component Data']?['Failed Item Part No'],
      stepperData['Failure Component Data']?['Failed Item Serial No'],
      stepperData['Failure Component Data']?['Original Installation Date'] ,
      stepperData['Failure Component Data']?['Cycle Counts Upon Failure'],
      stepperData['Failure Component Data']?['Failure Mode'],
      stepperData['Failure Component Data']?['Failure Cause'],
      stepperData['Failure Component Data']?['Failure Mechanism'],
      stepperData['Failure Component Data']?['Vendor OEM'],
      stepperData['Failure Component Data']?['Repair Location'],
      stepperData['Failure Component Data']?['Discovery Method'],
      stepperData['Failure Component Data']?['Failure Progress Status'],
      stepperData['Corrective Actions']?['Date Of Repair'],
      stepperData['Corrective Actions']?['New Item Part No'],
      stepperData['Corrective Actions']?['New Item Serial No'],
      stepperData['Corrective Actions']?['Repair Kit Part No'],
      stepperData['Corrective Actions']?['Corrective Actions Summary'],
     '0'
      // stepperData['attachments']?['attachments']
    );
print( stepperData['Basic Information']?['Rig Name']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()));


  }
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }


}
