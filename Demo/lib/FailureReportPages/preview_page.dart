import 'package:demo/FailureReportPages/success_page.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../forms/step_list.dart';

class PreviewPage extends StatefulWidget {

  final Map<String,Map<String,String>> data;

  const PreviewPage({required this.data});
  @override
  PreviewPageState createState() => PreviewPageState(data:data);
}

class PreviewPageState extends State<PreviewPage> {
   final Map<String,Map<String,String>> data;

  PreviewPageState({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Report'),
      ),
      body: Container(
        padding:  const EdgeInsets.all(20),
        child: Column(

          children: [Expanded(child:
            ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final key = data.keys.elementAt(index);
                final stepData = data.values.elementAt(index);
                final subtitles = stepData.keys.toList();
                final contents=stepData.values.toList();

                return Column(
                  children: [
                    ListTile(
                      title: Text(key),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                        subtitles.length,
                            (subIndex) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  const SizedBox(
                            height: 20,
                          ),
                            Text(subtitles[subIndex]),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(contents[subIndex]),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      ),

                    ),
                    const Divider()
                  ],
                );
              },
            ), ),ElevatedButton(
              onPressed: () =>   addFailure(),
          child: const Text('Create'))
          ],
        ),
      ),
    );

  //   final TextEditingController _titleController = TextEditingController();
  //   final TextEditingController _descriptionController = TextEditingController();
  //   return Container(
  //     padding: EdgeInsets.only(
  //       top: 15,
  //       left: 15,
  //       right: 15,
  //       // prevent the soft keyboard from covering the text fields
  //       bottom: MediaQuery.of(context).viewInsets.bottom + 120,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         TextField(
  //           controller: _titleController,
  //           decoration: const InputDecoration(hintText: 'Name'),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         TextField(
  //           controller: _descriptionController,
  //           decoration: const InputDecoration(hintText: 'Description'),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //
  //       ],
  //     ),
  //   );
   }
  // Implement the state and build method for the form page here
  // ...
   addFailure() async {

     await DatabaseHelper.createRig(  stepperData['basicInformation']?['failureTitle'], stepperData['basicInformation']?['rigName'],  stepperData['basicInformation']?['preparedBy'],
         stepperData['basicInformation']?['equipment'],  stepperData['basicInformation']?['failureType'],  stepperData['basicInformation']?['operator'],
         stepperData['basicInformation']!['failureDate']!, stepperData['basicInformation']?['bopSurface'], stepperData['basicInformation']?['eventName'],
         stepperData['basicInformation']?['pod'],  stepperData['prejectStatus']?['partDescription'], stepperData['prejectStatus']?['eventDescription'],
         stepperData['prejectStatus']?['indicationSymptoms'], stepperData['prejectStatus']?['impactedFunctions'],
         stepperData['prejectStatus']?['failureSeverity'],
         1,
         1,
         stepperData['basicInformation']!['failureDate']! ,
         stepperData['failureComponentData']?['cycleCountsUponFailure'],
         stepperData['failureComponentData']?['failureMode'],
         stepperData['failureComponentData']?['failureCause'],
         stepperData['failureComponentData']?['failureMechanism'],
         stepperData['failureComponentData']?['vendorOEM'],
         stepperData['failureComponentData']?['repairLocation'],
         stepperData['failureComponentData']?['discoveryMethod'],
         stepperData['failureComponentData']?['failureStatus'],
         stepperData['basicInformation']!['failureDate']!,
         1,
         1,1,
         stepperData['corrctiveActions']?['correctiveActionsSummary'],
         stepperData['attachments']?['attachments']
     );

     Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => SuccessPage()));


   }

}