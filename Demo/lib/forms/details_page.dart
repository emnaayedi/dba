import 'package:demo/FailureReportPages/success_page.dart';
import 'package:demo/forms/edit_page.dart';
import 'package:demo/forms/failures_list.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../navbars/bottom_navbar.dart';

class FailureDetailsPage extends StatefulWidget {
  final Map<String,Map<String,dynamic>> data;
  final int failureID;

  const FailureDetailsPage({required this.data,required this.failureID});
  @override
  FailureDetailsPageState createState() => FailureDetailsPageState(data:data,id:failureID);
}

class FailureDetailsPageState extends State<FailureDetailsPage> {
  final Map<String,Map<String,dynamic>> data;
  final int id;
  FailureDetailsPageState({required this.data,required this.id});
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Failure Details'),
          actions: [
      Row(
      children: [ PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),

              ),
              const PopupMenuItem<String>(
                value: 'generatePDF',
                child: Text('Generate PDF'),
              ),


            ];
          },
    onSelected: (String value) {
    // Handle item selection here
    if (value == 'edit') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditFailurePage(data: data, failureID: id)));
  } else if (value == 'delete') {
    deleteRig(id);
    }

          },
        ),
      ])]),
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
                  children: [ Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),child:
                    ListTile(

                      title: Text(key,style: TextStyle(fontSize: 23),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                        subtitles.length,
                            (subIndex) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  const SizedBox(
                            height: 20,
                          ),
                            Text(subtitles[subIndex],style: TextStyle(fontSize: 20),),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(contents[subIndex]!=null?contents[subIndex]:'--',style: TextStyle(fontSize: 18),),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      ),

                    ),
                ))                  ],
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