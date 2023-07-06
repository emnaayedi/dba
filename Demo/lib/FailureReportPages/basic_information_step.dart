import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dialogs/single_choice_dialog.dart';
import '../forms/step_list.dart';

class BasicInformationStep extends StatefulWidget {
  @override
  final bool isUpdate;
  final Map<String,dynamic>? data;

  const BasicInformationStep({ required this.isUpdate,this.data});

  @override
  BasicInformationStepState createState() =>
      BasicInformationStepState(isUpdate: isUpdate,data:this.data);

}

class BasicInformationStepState extends State<BasicInformationStep> {
  final bool isUpdate;
  final Map<String,dynamic>? data;
   BasicInformationStepState({ required this.isUpdate,this.data}) ;


  final TextEditingController _FailureTitleController = TextEditingController();
  final TextEditingController _RigNameController = TextEditingController();
  final TextEditingController _PreparedByController = TextEditingController();
  final TextEditingController _EquipmentController = TextEditingController();
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
    'Surface',
    'Subsea',
    'Running and pulling riser',
    'Repairs and upgrade',
    'New build'
  ];
  late Map<String, String> failureStatusResult;
  late Map<String, String> operationsResult;
  late String failureStatusValue;
  late String operationsValue;
  String failureStatusButtonText = 'Select Failure Status';
  String operationsButtonText = 'Select Operations';
  late int selectedFailureType ;
  late int selectedPod ;
  DateTime failureDate = DateTime.now();


  @override
  void initState() {

    super.initState();
    if(isUpdate){

        switch (data!['Failure Type']){
          case 'Operational Event':
        selectedFailureType= 0;
        break;
          case 'IBWM Event':
            selectedFailureType=1;
            break;
        }
        switch (data!['Pod']) {
          case 'Blue Pod':
           selectedPod=0;
            // Perform specific actions for apple
            break;

          case 'Yellow Pod':
          selectedPod=1;
            break;
          case 'Surface':
            selectedPod=2;
            // Perform specific actions for apple
            break;



    }

        _FailureTitleController..text=data?['Failure Title']!=null?data!['Failure Title']:'' ;
        _RigNameController ..text=data?['Rig Name']!=null?data!['Rig Name']:'' ;
        _PreparedByController ..text=data?['Prepared By']!=null?data!['Prepared By']:'' ;
        _EquipmentController ..text=data?['Equipment']!=null?data!['Equipment']:'';
        _operatorController ..text=data?['Operator'] !=null?data!['Operator']:'' ;
        _contractorController ..text=data?['Controller']!=null?data!['Controller']:''  ;
        _dRNumberController ..text=data?['DR Number']!=null?data!['DR Number']:'' ;
        _wellNameController ..text=data?['Well Name']!=null? data!['Well Name']:'';
        _bopSurfaceController ..text=data?['BOP Surface']!=null?data!['BOP Surface']:'' ;
        _eventNameController ..text=data?['Event Name']!=null?data!['Event Name']:'';}else{
    stepperData['Basic Information']?['Failure Date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    stepperData['Basic Information']?['Failure Type'] ='Operational Event';
    stepperData['Basic Information']?['Pod'] ='Blue Pod';
    selectedFailureType=0;
    selectedPod=0;}


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

        if(isUpdate){data?['Failure Date']=DateFormat('yyyy-MM-dd').format(picked);}else{stepperData['Basic Information']?['Failure Date'] = DateFormat('yyyy-MM-dd').format(picked);}

      });
    }
  }
  Future <void> _selectFailureStatusOption(BuildContext context) async {
    try {
      failureStatusResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(
            data: failureStatus, title: 'Failure Status',);
        },
      ))!;

      setState(() {
        failureStatusButtonText = failureStatusResult['option']!;
        if(isUpdate){
          data?['Failure Status']=failureStatusResult['option']!;
        }else{

        stepperData['Basic Information']?['Failure Status'] =
        failureStatusResult['option']!;
      }});
    } catch(e){}

  }
  Future <void> _selectOperationsOption(BuildContext context) async {
    try {
      operationsResult = (await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          return SingleChoiceDialog(data: operations, title: 'Operations',);
        },
      ))!;
      setState(() {
        operationsButtonText = operationsResult['option']!;
        if(isUpdate){
          data?['Operations']=failureStatusResult['option']!;
        }else {
          stepperData['Basic Information']?['Operations'] =
          operationsResult['option']!;
        }});
    }catch(e){}

  }
  Widget cardButtonFailureType(String assetName, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedFailureType= index;
          if(isUpdate){
            data?['Failure Type']=assetName!;
          }else{
          stepperData['Basic Information']?['Failure Type'] = assetName;

        }});
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
          if(isUpdate){
            data?['Pod']=assetName;
          }else{
          stepperData['Basic Information']?['Pod'] = assetName;

        }});
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
            'FailureTitle',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),SizedBox(width:300,child:
          TextField(
            controller: _FailureTitleController,
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
                hintText: 'Enter Failure Title'),
            onChanged: (value) {
    if(isUpdate){
    data?['Failure Title']=value;
    }else{
              stepperData['Basic Information']?['Failure Title'] = value;
            }},
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Rig Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
   SizedBox(width:250,child:
          TextField(
            controller: _RigNameController,
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
                hintText: 'Enter Rig Name'),
            onChanged: (value) {
              if(isUpdate){
                data?['Rig Name']=value;
              }else{
                stepperData['Basic Information']?['Rig Name'] = value;
              }},
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Prepared By',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
   SizedBox(width:300,child:
          TextField(
            controller: _PreparedByController,
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
    if(isUpdate){
    data?['Prepared By']=value;
    }else{
              stepperData['Basic Information']?['Prepared By'] = value;
            }},
          )),
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
   SizedBox(width:300,child:
          TextField(
            controller: _EquipmentController,
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
    if(isUpdate){
    data?['Equipment']=value;
    }else{
              stepperData['Basic Information']?['Equipment'] = value;
            }},
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select Failure Type',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
          ),SizedBox(width:300,child:
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
    if(isUpdate){
    data?['Operator']=value;
    }else{
              stepperData['Basic Information']?['Operator'] = value;
            }},
          )),
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
            label: Text( isUpdate?data!['Failure Date']:'${DateFormat('yyyy-MM-dd').format(failureDate)}',
              style:const TextStyle(color: Color(0xff020202)),



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
         SizedBox(width:300,child:
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
    if(isUpdate){
    data?['Contractor']=value;
    }else{
              stepperData['Basic Information']?['Contractor'] = value;
            }},
          )),
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
   SizedBox(width:200,child:
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
    if(isUpdate){
    data?['DR Number']=value;
    }else{
              stepperData['Basic Information']?['DR Number'] = value;
            }},
          )),
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
   SizedBox(width:300,child:
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
    if(isUpdate){
    data?['Well Name']=value;
    }else{
              stepperData['Basic Information']?['Well Name'] = value;
            }},
          )),
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
            child:SizedBox(width:250,
              child: Row(
                  children: [isUpdate?Text(data!['Failure Status']):
                    Text(failureStatusButtonText,style: TextStyle(fontSize: 18),),
                    Icon(Icons.keyboard_arrow_down)
                  ]),
            ),

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
            child:SizedBox(width:200,
              child: Row(
                  children: [isUpdate?Text(data!['Operations']):
                    Text(operationsButtonText,style: TextStyle(fontSize: 18),),
                    Icon(Icons.keyboard_arrow_down)
                  ]),
            ),
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
   SizedBox(width:300,child:
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
    if(isUpdate){
    data?['BOP Surface']=value;
    }else{
              stepperData['Basic Information']?['BOP Surface'] = value;
            }},
          )),
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
   SizedBox(width:300,child:
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
    if(isUpdate){
    data?['Event Name']=value;
    }else{
              stepperData['Basic Information']?['Event Name'] = value;
            }},
          )),
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