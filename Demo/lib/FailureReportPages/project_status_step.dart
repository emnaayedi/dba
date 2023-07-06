import 'package:flutter/material.dart';

import '../forms/step_list.dart';

class ProjectStatusStep extends StatefulWidget {
  @override
  final Key? key;
  const ProjectStatusStep({this.key}) : super(key: key);
  @override
  ProjectStatusStepState createState() => ProjectStatusStepState();
}

class ProjectStatusStepState extends State<ProjectStatusStep> {
  final TextEditingController _partDescriptionController =
  TextEditingController();
  final TextEditingController _eventDescriptionController =
  TextEditingController();
  final TextEditingController _indicationSymptomsController =
  TextEditingController();
  final TextEditingController _impactedFunctionsPotentialRisksController =
  TextEditingController();
  int selectedFailureType = 0;

  Widget failureSeverityCardButton(String assetName, int index) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            selectedFailureType = index;
            stepperData['Project Status']?['Failure Severity'] = assetName;

          });
        },
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(17),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: const BorderSide(color: Color(0xff505050)),
            backgroundColor: (selectedFailureType == index) ? const Color(0xff505050): const Color(0xffFFFFFF)),
        child: Text(assetName,style: TextStyle(color: selectedFailureType == index ? const Color(0xffFFFFFF): const Color(0xff000000),
          fontFamily: 'RobotoRegular',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,)
        )
    );
  }
  @override
  void initState() {
    super.initState();
    stepperData['Project Status']?['Failure Severity'] = '[1] Stack/LMPR Pull';
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Part description',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          SizedBox(width:600,child:
            TextField(
              controller: _partDescriptionController,
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
                  hintText: 'Enter part description'),
              onChanged: (value) {
                stepperData['Project Status']?['Part Description'] = value;
              },
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Event description',
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
              width:600,

              child: TextField(

                textAlignVertical: TextAlignVertical.top,
                controller: _eventDescriptionController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff000000),
                    ),
                  ),
                  hintText: 'Enter event description',),
                onChanged: (value) {
                  stepperData['Project Status']?['Event Description'] = value;
                },
                maxLines: null,
                expands: true,

              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
               'Indication/Symptoms',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
  SizedBox(width:600,child:
            TextField(
              controller: _indicationSymptomsController,
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
                  hintText: 'Enter indication / Symptoms'),
              onChanged: (value) {
                stepperData['Project Status']?['Indication Symptoms'] = value;
              },
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Impacted Function / Potential Risks',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
  SizedBox(width:600,child:
            TextField(
              controller: _impactedFunctionsPotentialRisksController,
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
                  hintText: 'Enter impacted function / potential risks'),
              onChanged: (value) {
                stepperData['Project Status']?['Impacted Functions'] = value;
              },
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Failure Severity',
              style: TextStyle(
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
                  child: failureSeverityCardButton('[1] Stack/LMPR Pull', 0),
                ),

                Expanded(
                  child: failureSeverityCardButton('[2] Deviation', 1),
                ),

                Expanded(
                  child: failureSeverityCardButton('Surface', 2),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ]);
  }
}