import 'package:camera/camera.dart';
import 'package:demo/forms/failures_list.dart';
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:demo/db/database_helper.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:open_file/open_file.dart';
import 'NotifactionsPages/Notifications.dart';
import 'camera/camera_page.dart';
import 'forms/step_list.dart';
import 'navbars/bottom_navbar.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compliance Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/notifications': (context) => Notifications(),
        '/failures_list': (context) => FailuresList(),

      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // All data

  List<Map<String, dynamic>> _myData = [];

  List<Map<String, dynamic>> get myData => _myData;

  bool _isLoading = true;
  get firstCamera => null;
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


  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await DatabaseHelper.getRigs();
    setState(() {
      _myData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void showMyForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingData = _myData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['name'];
      _descriptionController.text = existingData['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new data
                      if (id == null) {
                        await addRig();
                      }

                      if (id != null) {
                        await updateRig(id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descriptionController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

// Insert a new data to the database

  Future<void> addRig() async {

    _refreshData();
  }
  Future<void> requestExternalStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, continue accessing the external storage
    } else {
      // Permission denied, handle the error gracefully
    }
  }
  Future<void> _createPDF() async {
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
    final data = await rootBundle.load('assets/failureReportTemplate.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);


    /*
    Or in the case of Flutter, you can use rootBundle.load, then get bytes

    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

    // Load test image for inserting in docx

    final listNormal = ['Foo', 'Bar', 'Baz'];
    final listBold = ['ooF', 'raB', 'zaB'];

    final contentList = <Content>[];

    final b = listBold.iterator;
    for (var n in listNormal) {
      b.moveNext();

      final c = PlainContent("value")
        ..add(TextContent("normal", n))
        ..add(TextContent("bold", b.current));
      contentList.add(c);
    }

    Content c = Content();
    c
      ..add(TextContent("docnam", "Simple docname"))
      ..add(TextContent("passport", "Passport NE0323 4456673"))
      ..add(TextContent("Failure Title", "Alex"))
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
    final of = File('$path/gener5.docx');
      OpenFile.open('$path/gener5.docx');

      if (d != null) await of.writeAsBytes(d);
    } else {
print("denied");    }
  }

  // Update an existing data
  Future<void> updateRig(int id) async {
    await DatabaseHelper.updateRig(
        id, _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Delete an Rig
  void deleteRig(int id) async {
    await DatabaseHelper.deleteRig(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top:80.0,left: 16),
        child: Column(

                      crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          Text(DateFormat('MMMM dd, yyyy').format(DateTime.now()),style: TextStyle(fontSize: 20)),
                          const SizedBox(
                            height: 30,
                          ),
                          Text('Quick Access',style: TextStyle(fontSize: 30),),

                          const SizedBox(
                            height: 20,
                          ),


                   Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                ElevatedButton.icon(


                                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),padding: EdgeInsets.all(24)),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => FailuresList()));
                                  },
                                  icon: Icon(Icons.playlist_remove,size: 30),
                                  label: const Text('Failure Report List',style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text('Handover Note',style: TextStyle(fontSize: 30),),

                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              ElevatedButton.icon(


                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),padding: EdgeInsets.symmetric(vertical:50,horizontal: 16)),
                                onPressed: () {

                                },
                                icon:


                                    Icon(Icons.add,size: 30),

                                label: Row(
                                  children: [
                                    const Text('Create New Note',style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ),
                            ],
                          ),

                      // Expanded(
                      //   flex:1,
                      //   child: SafeArea(
                      //     child: Center(
                      //         child: ElevatedButton(
                      //       onPressed: () async {
                      //         await availableCameras().then((value) =>
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (_) =>
                      //                         CameraPage(cameras: value))));
                      //       },
                      //       child: const Icon(Icons.camera_alt),
                      //     )),
                      //   ),
    // ),

                      // Expanded(
                      //   // If you don't have the height you can expanded with flex
                      //   flex: 1,
                      //   child: ListView.builder(
                      //     itemCount: _myData.length,
                      //     itemBuilder: (context, index) => Card(
                      //         color: index % 2 == 0
                      //             ? Colors.white10
                      //             : Colors.white60,
                      //         margin: const EdgeInsets.all(15),
                      //         child: ListTile(
                      //             title: Text(_myData[index]['Failure Title']),
                      //             subtitle: Text(_myData[index]['Rig Name']),
                      //             trailing: SizedBox(
                      //               width: 100,
                      //               child: Row(
                      //                 children: [
                      //                   IconButton(
                      //                     icon: const Icon(Icons.edit),
                      //                     onPressed: () =>
                      //                         showMyForm(_myData[index]['id']),
                      //                   ),
                      //                   IconButton(
                      //                     icon: const Icon(Icons.delete),
                      //                     onPressed: () =>
                      //                         deleteRig(_myData[index]['id']),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ))),
                      //   ),
                      // // ),
                      // ElevatedButton(
                      //   onPressed: _createPDF,
                      //   child: const Text('Generate Report'),
                      // )
                    ]),
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () => showMyForm(null),
      // ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),

    );
  }
}
