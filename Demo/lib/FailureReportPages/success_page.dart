import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import 'package:demo/main.dart';
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../navbars/bottom_navbar.dart';

class SuccessPage extends StatefulWidget {

  final Map<String,Map<String,dynamic>> data;

  const SuccessPage({required this.data});
  @override
  SuccessPageState createState() => SuccessPageState(data:data);
}

class SuccessPageState extends State<SuccessPage> {
  final Map<String,Map<String,dynamic>> data;

  SuccessPageState({required this.data});


//   List<String> rigs = <String>['One', 'Two', 'Three', 'Four'];
//   List<String> Equipments = <String>['BOP1', 'BOP2', 'Surface Equipment'];
//   List<String> Failure Types = <String>['Operational Event', 'IBWM Event'];
//   List<String> operations = <String>['One', 'Two', 'Three', 'Four'];
//   List<String> discoveries = <String>['One', 'Two', 'Three', 'Four'];
//   late String rig ;
//   late String Equipment ;
//   late String Failure Type ;
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
//     Equipment=Equipments.first;
//     Failure Type=Failure Types.first;
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

  genearteReport() async {
    print(this.data);
    //Create a new PDF document
    // PdfDocument document = PdfDocument();
    //
    // //Add a new page and draw text
    // document.pages.add().graphics.drawString(
    //     'Failure Report', PdfStandardFont(PdfFontFamily.helvetica, 20),
    //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    //     bounds: const Rect.fromLTWH(0, 0, 500, 50));
    //
    // //Save the document
    // List<int> bytes = await document.save();
    //
    // //Dispose the document
    // document.dispose();
    // //Get external storage directory
    // final externalDirectory = await getExternalStorageDirectory();
    //
    // //Get directory path
    // final path = externalDirectory?.path;
    // final fileName ='failure_report_${DateFormat("yyyy-MM-dd").format(DateTime.now())}';
    // //Create an empty file to write PDF data
    // File file = File('$path/$fileName.pdf');
    //
    // //Write PDF data
    // await file.writeAsBytes(bytes, flush: true);
    //
    // //Open the PDF document in mobile
    // OpenFile.open('$path/$fileName.pdf');

      //Create a new PDF document
      // PdfDocument document = PdfDocument();
      //
      // //Add a new page and draw text
      // document.pages.add().graphics.drawString(
      //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
      //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      //     bounds: const  Rect.fromLTWH(0, 0, 500, 50));

      //Save the document
      // List<int> bytes = await document.save();

      //Dispose the document
      // document.dispose();
      //Get external storage directory
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final externalDirectory = await getExternalStorageDirectory();
        final path = externalDirectory?.path;



        //Get directory path

        //Create an empty file to write PDF data
        // File file = File('$path/Output.pdf');

        //Write PDF data
        // await file.writeAsBytes(bytes, flush: true);

        //Open the PDF document in mobile
        // OpenFile.open('$path/Output.pdf');
        // final templateBytes = await rootBundle.load('assets/email.docx');
        // final bytesDocx = templateBytes.buffer.asUint8List();
        // final docx = await DocxTemplate.fromBytes(bytesDocx);
        // Content content = Content();
        // final docGenerated = await docx.generate(content);
        // final fileGenerated = File('$path/generated.docx');
        // if (docGenerated != null) await fileGenerated.writeAsBytes(docGenerated);
        // print( await  file.path.toString());
        //
        // if (docGenerated != null) await fileGenerated.writeAsBytes(docGenerated);
        // AndroidIntent intent = AndroidIntent(
        //   action: 'action_view',
        //   type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        //   data: '$path/generated.docx',  // Replace with the actual file path
        // );
        // intent.launch();
        final data = await rootBundle.load('assets/failureReportTemplat.docx');
        final bytes = data.buffer.asUint8List();
        final docx = await DocxTemplate.fromBytes(bytes);


        /*
    Or in the case of Flutter, you can use rootBundle.load, then get bytes

    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */


        Content c = Content();
        c
          ..add(TextContent("CreatedAt", DateFormat("yyyy-MM-dd").format(DateTime.now())))
          ..add(TextContent("Failure Title", this.data['Basic Information']!['Failure Title']))
          ..add(TextContent("Rig Name", this.data['Basic Information']!['Rig Name']))
          ..add(TextContent("Prepared By", this.data['Basic Information']!['Prepared By']))
          ..add(TextContent("Equipment", this.data['Basic Information']!['Equipment']))
          ..add(TextContent("Failure Type", this.data['Basic Information']!['Failure Type']))
          ..add(TextContent("Operator", this.data['Basic Information']!['operator']))
          ..add(TextContent("FailureDate", this.data['Basic Information']!['failureDate']))
          ..add(TextContent("Contractor", this.data['Basic Information']!['contractor']))
          ..add(TextContent("DRNumber", this.data['Basic Information']!['drNumber']))
          ..add(TextContent("WellName", this.data['Basic Information']!['wellName']))
          ..add(TextContent("FailureStatus", this.data['Basic Information']!['failureStatus']))
          ..add(TextContent("Operations", this.data['Basic Information']!['operations']))
          ..add(TextContent("BOPSurface", this.data['Basic Information']!['bopSurface']))
          ..add(TextContent("EventName", this.data['Basic Information']!['eventName']))
          ..add(TextContent("Pod", this.data['Basic Information']!['pod']))
          ..add(TextContent("PartDescription", this.data['Project Status']!['partDescription']))
          ..add(TextContent("EventDescription", this.data['Project Status']!['eventDescription']))
          ..add(TextContent("IndicationSymptoms", this.data['Project Status']!['indicationSymptoms']))
          ..add(TextContent("ImpactedFunctions", this.data['Project Status']!['impactedFunctions']))
          ..add(TextContent("FailureSeverity", this.data['Project Status']!['failureSeverity']))
          ..add(TextContent("FailedItemPartNo", this.data['Failure Component Data']!['failedItemPartNo']))
          ..add(TextContent("FailedItemSerialNo", this.data['Failure Component Data']!['failedItemSerialNo']))
          ..add(TextContent("OriginalInstallationDate", this.data['Failure Component Data']!['originalInstallationDate']))
          ..add(TextContent("CycleCountsUponFailure", this.data['Failure Component Data']!['cycleCountsUponFailure']))
          ..add(TextContent("FailureMode", this.data['Failure Component Data']!['failureMode']))
          ..add(TextContent("FailureCause", this.data['Failure Component Data']!['failureCause']))
          ..add(TextContent("FailureMechanism", this.data['Failure Component Data']!['failureMechanism']))
          ..add(TextContent("VendorOEM", this.data['Failure Component Data']!['vendorOEM']))
          ..add(TextContent("RepairLocation", this.data['Failure Component Data']!['repairLocation']))
          ..add(TextContent("DiscoveryMethod", this.data['Failure Component Data']!['discoveryMethod']))
          ..add(TextContent("FailureProgressStatus", this.data['Failure Component Data']!['failureProgressStatus']))
          ..add(TextContent("DateOfRepair", this.data['Corrective Actions']!['dateOfRepair']))
          ..add(TextContent("NewItemPartNo", this.data['Corrective Actions']!['newItemPartNo']))
          ..add(TextContent("NewItemSerialNo", this.data['Corrective Actions']!['newItemSerialNo']))
          ..add(TextContent("RepairKitPartNo", this.data['Corrective Actions']!['repairKitPartNo']))
          ..add(TextContent("CorrectiveActionsSummary", this.data['Corrective Actions']!['correctiveActionsSummary']))






        // ..add(TableContent("table", [
        //   RowContent()
        //     ..add(TextContent("key1", "Paul"))
        //     ..add(TextContent("key2", "Viberg"))
        //     ..add(TextContent("key3", "Engineer")),
        //   RowContent()
        //
        //     ..add(TextContent("key2", "Houser"))
        //     ..add(TextContent("key3", "CEO & Founder"))
        //     ..add(ListContent("tablelist", [
        //       TextContent("value", "Mercedes-Benz C-Class S205"),
        //       TextContent("value", "Lexus LX 570")
        //     ]))
        // ]))
        // ..add(ListContent("list", [
        //   TextContent("value", "Engine")
        //     ..add(ListContent("listnested", contentList)),
        //   TextContent("value", "Gearbox"),
        //   TextContent("value", "Chassis")
        // ]))
        // ..add(ListContent("plainlist", [
        //   PlainContent("plainview")
        //     ..add(TableContent("table", [
        //       RowContent()
        //         ..add(TextContent("key1", "Paul"))
        //         ..add(TextContent("key2", "Viberg"))
        //         ..add(TextContent("key3", "Engineer")),
        //       RowContent()
        //         ..add(TextContent("key1", "Alex"))
        //         ..add(TextContent("key2", "Houser"))
        //         ..add(TextContent("key3", "CEO & Founder"))
        //         ..add(ListContent("tablelist", [
        //           TextContent("value", "Mercedes-Benz C-Class S205"),
        //           TextContent("value", "Lexus LX 570")
        //         ]))
        //     ])),
        //   PlainContent("plainview")
        //     ..add(TableContent("table", [
        //       RowContent()
        //         ..add(TextContent("key1", "Nathan"))
        //         ..add(TextContent("key2", "Anceaux"))
        //         ..add(TextContent("key3", "Music artist"))
        //         ..add(ListContent(
        //             "tablelist", [TextContent("value", "Peugeot 508")])),
        //       RowContent()
        //         ..add(TextContent("key1", "Louis"))
        //         ..add(TextContent("key2", "Houplain"))
        //         ..add(TextContent("key3", "Music artist"))
        //         ..add(ListContent("tablelist", [
        //           TextContent("value", "Range Rover Velar"),
        //           TextContent("value", "Lada Vesta SW Sport")
        //         ]))
        //     ])),
        // ]))
        // ..add(ListContent("multilineList", [
        //   PlainContent("multilinePlain")
        //     ..add(TextContent('multilineText', 'line 1')),
        //   PlainContent("multilinePlain")
        //     ..add(TextContent('multilineText', 'line 2')),
        //   PlainContent("multilinePlain")
        //     ..add(TextContent('multilineText', 'line 3'))
        // ]))
        // ..add(TextContent('multilineText2', 'line 1\nline 2\n line 3'))
        //
        //
        //


            ;

        final d = await docx.generate(c);
        final pdf = pw.Document();




        // Get the document directory path
        // final directory = await getApplicationDocumentsDirectory();
        // final String filePath = '${directory.path}/output.pdf';
        //
        // // Save the PDF file
        // final file = File(filePath);
        // await file.writeAsBytes(await pdf.save());

        final of = File('$path/failure_report_${DateFormat("yyyy-MM-dd HH-mm-ss").format(DateTime.now())}.docx');

        if (d != null) await of.writeAsBytes(d);
        OpenFile.open('$path/failure_report_${DateFormat("yyyy-MM-dd HH-mm-ss").format(DateTime.now())}.docx');

      } else {
        print("denied");    }
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
            ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),);
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
//             value: Equipment,
//             items: Equipments.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 Equipment = newValue!;
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
//             value: Failure Type,
//             items: Failure Types.map((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option),
//               );
//             }).toList(),
//             onChanged: ( newValue) {
//               setState(() {
//                 Failure Type = newValue!;
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