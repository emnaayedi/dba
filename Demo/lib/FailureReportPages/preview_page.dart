import 'package:demo/FailureReportPages/success_page.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../forms/step_list.dart';
import '../navbars/bottom_navbar.dart';

class PreviewPage extends StatefulWidget {

  final Map<String,Map<String,dynamic>> data;

  const PreviewPage({required this.data});
  @override
  PreviewPageState createState() => PreviewPageState(data:data);
}

class PreviewPageState extends State<PreviewPage> {
   final Map<String,Map<String,dynamic>> data;

  PreviewPageState({required this.data});
   int _currentIndex = 0;

   void _onTabTapped(int index) {
     setState(() {
       _currentIndex = index;
     });
     if (index == 0) {
       // Navigate to Home Page
       Navigator.pushReplacementNamed(context, '/home');
     } else if (index == 1) {
       // Navigate to Search Page
       Navigator.pushReplacementNamed(context, '/notifications');
     } else if (index == 2) {
       // Navigate to Settings Page
       Navigator.pushReplacementNamed(context, '/failures_list');
     }
   }
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
          child: const Text('Create Report'))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
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

     await DatabaseHelper.createRig(  stepperData['Basic Information']?['Failure Title'], stepperData['Basic Information']?['Rig Name'],  stepperData['Basic Information']?['Prepared By'],
         stepperData['Basic Information']?['Equipment'],  stepperData['Basic Information']?['Failure Type'],  stepperData['Basic Information']?['Operator'],
         stepperData['Basic Information']?['Failure Date'],  stepperData['Basic Information']?['Contractor'],
       stepperData['Basic Information']?['DR Number'],  stepperData['Basic Information']?['Well Name'],  stepperData['Basic Information']?['Failure Status'],  stepperData['Basic Information']?['Operations'], stepperData['Basic Information']?['BOP Surface'], stepperData['Basic Information']?['Event Name'],
         stepperData['Basic Information']?['Pod'],  stepperData['Project Status']?['part Description'], stepperData['Project Status']?['Event Description'],
         stepperData['Project Status']?['Indication Symptoms'], stepperData['Project Status']?['Impacted Functions'],
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
       stepperData['Corrective Actions']?['ewItemPartNo'],
       stepperData['Corrective Actions']?['New Item Serial No'],
      stepperData['Corrective Actions']?['Repair Kit Part No'],
         stepperData['Corrective Actions']?['Corrective Actions Summary'],'1'

         // stepperData['attachments']?['attachments']
     );

     Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => SuccessPage(data:this.data)));


   }

}