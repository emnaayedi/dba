import 'dart:io';

import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SuccessPage extends StatefulWidget {
  @override
  final Key? key;

  const SuccessPage({this.key}) : super(key: key);
  @override
  SuccessPageState createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage>   {


//   List<String> rigs = <String>['One', 'Two', 'Three', 'Four'];
//   List<String> equipments = <String>['BOP1', 'BOP2', 'Surface Equipment'];
//   List<String> failureTypes = <String>['Operational Event', 'IBWM Event'];
//   List<String> operations = <String>['One', 'Two', 'Three', 'Four'];
//   List<String> discoveries = <String>['One', 'Two', 'Three', 'Four'];
//   late String rig ;
//   late String equipment ;
//   late String failureType ;
//   late String operation ;
//   late String discovery ;
//   late DateTime failureDate=DateTime.now();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//
//   @override
//   bool get wantKeepAlive => true;
//   @override
//   void initState() {
//     super.initState();
//     rig = rigs.first;
//     equipment=equipments.first;
//     failureType=failureTypes.first;
//     operation=operations.first;
//     discovery=discoveries.first;
//
// // Initialize the selected option
//   }
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       helpText: 'Select failure date', // Can be used as title
//       cancelText: 'Not now',
//       confirmText: 'Book',
//     );
//
//     if (picked != null && picked != failureDate) {
//       setState(() {
//         failureDate = picked;
//       });
//     }
//   }
//
  genearteReport() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    //Add a new page and draw text
    document.pages.add().graphics.drawString(
        'Failure Report', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 500, 50));

    //Save the document
    List<int> bytes = await document.save();

    //Dispose the document
    document.dispose();
    //Get external storage directory
    final externalDirectory = await getExternalStorageDirectory();

    //Get directory path
    final path = externalDirectory?.path;
    final fileName ='failure_report_${DateFormat("yyyy-MM-dd").format(DateTime.now())}';
    //Create an empty file to write PDF data
    File file = File('$path/$fileName.pdf');

    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);

    //Open the PDF document in mobile
    OpenFile.open('$path/$fileName.pdf');
  }

  @override
  Widget build(BuildContext context) {
//
    return Scaffold(
        appBar: AppBar(
          title: const Text('Failure Report Confirmation'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Theme(
            data: ThemeData(brightness: Brightness.light,
                primarySwatch: Colors.orange,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: const Color(0xff878787)),
                secondaryHeaderColor: const Color(0xff878787),
                iconTheme: Theme
                    .of(context)
                    .iconTheme
                    .copyWith(size: 32.0)

            ), child:
            Padding(
              padding: const EdgeInsets.only(top:100),
              child: Center(child:
      Column(children: [
                const Text(
                  'Success!',
                  style: TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    color: Color(0xff000000),
                  ),

                ), const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Your report has been created',
                  style: TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Icon(
                  Icons.check_circle,
                  color: Colors.green, // Set the desired color for the tick icon
                  size: 140, // Set the desired size for the tick icon
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical:10,horizontal: 85), // Set the desired padding
                        ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff212121)),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(

                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          // Set the desired border radius
                        ),

                      ),


                    ),
                    onPressed: () =>genearteReport(),
                    child: const Text(
                      'DOWNLOAD PDF',
                      style: TextStyle(color: Color(0xffFFFFFF)),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical:10,horizontal: 85), // Set the desired padding
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffF5F5F5)),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(

                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Color(0xffBDBDBD)),
                          // Set the desired border radius
                        ),

                      ),


                    ),
                    onPressed: () {  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage()));},
                    child: const Text(
                      style:TextStyle(color: Color(0xff020202)),
                      'GO HOME PAGE',
                    ))
              ],
              ))),
            ));
//         child:Padding(
//       padding: EdgeInsets.only(
//         top: 15,
//         left: 15,
//         right: 15,
//         // prevent the soft keyboard from covering the text fields
//         bottom: MediaQuery.of(context).viewInsets.bottom + 120,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           TextField(
//             controller: _titleController,
//             decoration: const InputDecoration(hintText: 'Name'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//
//           DropdownButtonFormField<String>(
//             value: rig,
//             items: rigs.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//               rig = newValue!;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Name of Rig',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           DropdownButtonFormField<String>(
//             value: equipment,
//             items: equipments.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 equipment = newValue!;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Equipment',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           DropdownButtonFormField<String>(
//             value: failureType,
//             items: failureTypes.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 failureType = newValue!;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Failure Type',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             failureDate != null
//                 ? 'Selected Date: ${failureDate.toString()}'
//                 : 'No Date Selected',
//           ),
//           ElevatedButton(
//             onPressed: () => _selectDate(context),
//             child: Text('Select Date'),
//           ),
//           DropdownButtonFormField<String>(
//             value: operation,
//             items: operations.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 operation = newValue!;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Operations',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           DropdownButtonFormField<String>(
//             value: discovery,
//             items: discoveries.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 discovery = newValue!;
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Discovery',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextField(
//             controller: _descriptionController,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 3, color: Colors.greenAccent),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//               ),
//                 hintText: 'Description'),
//           ),
//          ],
//       ),
//     ),
//         bucket: PageStorageBucket());
//   }
    // Implement the state and build method for the form page here
    // ...
  }}