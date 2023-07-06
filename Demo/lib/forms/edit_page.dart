import 'package:demo/FailureReportPages/success_page.dart';
import 'package:demo/forms/failures_list.dart';
import 'package:flutter/material.dart';

import '../FailureReportPages/basic_information_step.dart';
import '../FailureReportPages/corrective_actions_step.dart';
import '../FailureReportPages/failure_component_data_step.dart';
import '../FailureReportPages/project_status_step.dart';
import '../db/database_helper.dart';
import '../navbars/bottom_navbar.dart';

class EditFailurePage extends StatefulWidget {
  final Map<String,Map<String,dynamic>> data;
  final int failureID;

  const EditFailurePage({required this.data,required this.failureID});
  @override
  EditFailurePageState createState() => EditFailurePageState(data:data,id:failureID);
}

class EditFailurePageState extends State<EditFailurePage> {
  final Map<String,Map<String,dynamic>> data;
  final int id;
  EditFailurePageState({required this.data,required this.id});
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
  void deleteRig(int id) async {
    await DatabaseHelper.deleteRig(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FailuresList()));

  }
  Future<void> updateRig(int id) async {
    // await DatabaseHelper.updateRig(
    //     id, _titleController.text, _descriptionController.text);
    // _refreshData();
  }
  List<Widget> getSteps() {
    var items = [
    BasicInformationStep(isUpdate: true,data:data['Basic Information']),

    ProjectStatusStep(),
       FailureComponentDataStep(),
       CorrectiveActionsStep()
    ];
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Failure Details'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child:          ElevatedButton.icon(
                icon:Icon(Icons.drafts_outlined),
                label: const Text('Save'),


                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),backgroundColor: Colors.white10),

                onPressed: () => updateRig(id)),

          )],),
      body: Container(
        padding:  const EdgeInsets.all(20),
        child: Column(

          children: [Expanded(child:
          ListView.builder(
            itemCount: getSteps().length,
            itemBuilder: (context, index) {


              return Column(
                children: [ Card(
child: getSteps()[index],
                      ),

                                      ],
              );
            },
          ), ),
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
}