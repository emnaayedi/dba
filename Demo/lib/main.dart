import 'package:camera/camera.dart';
import 'package:demo/forms/failures_list.dart';
import 'package:flutter/material.dart';
import 'package:demo/db/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'camera/camera_page.dart';
import 'forms/step_list.dart';

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

  Future<void> _createPDF() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    //Add a new page and draw text
    document.pages.add().graphics.drawString(
        'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const  Rect.fromLTWH(0, 0, 500, 50));

    //Save the document
    List<int> bytes = await document.save();

    //Dispose the document
    document.dispose();
    //Get external storage directory
    final externalDirectory = await getExternalStorageDirectory();

    //Get directory path
    final path = externalDirectory?.path;

    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');

    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);

    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
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
      appBar: AppBar(
        title: const Text('Rigs'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
           )
              : Center(
                  child: Column(
                      children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => StepList()));
                      },
                      child: const Text('Create New Failure'),
                    ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => FailuresList(data: _myData)));
                          },
                          child: const Text('Failures List'),
                        ),
                    Expanded(
                      flex:1,
                      child: SafeArea(
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () async {
                            await availableCameras().then((value) =>
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            CameraPage(cameras: value))));
                          },
                          child: const Icon(Icons.camera_alt),
                        )),
                      ),
                    ),

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
                    //             title: Text(_myData[index]['failureTitle']),
                    //             subtitle: Text(_myData[index]['rigName']),
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
                    // ),
                    ElevatedButton(
                      onPressed: _createPDF,
                      child: const Text('Generate Report'),
                    )
                  ]),
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showMyForm(null),
      ),
    );
  }
}
