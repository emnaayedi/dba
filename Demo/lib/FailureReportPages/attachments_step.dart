import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentsStep extends StatefulWidget {
  @override
  final Key? key;
  const AttachmentsStep({this.key}) : super(key: key);

  @override
  AttachmentsStepState createState() => AttachmentsStepState();
}

class AttachmentsStepState extends State<AttachmentsStep> {
  List<File> uploadedFiles = [];
  @override
  Widget build(BuildContext context) {
    return  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload any attachments',
                style:  TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    iconColor:MaterialStateProperty.all<Color>( const Color(0xff020202)),
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
                  onPressed: openAttachmentWindow,
                  label: const Text('UPLOAD ATTACHMENTS', style:TextStyle(color: Color(0xff020202)),),
                  icon: const Icon(Icons.add)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: uploadedFiles.length,
                  itemBuilder: (context, index) {
                    final File file = uploadedFiles[index];
                    return ListTile(leading:Image.file(file),
                      title: Text(file.path.split('/').last),
                      // Customize the list tile as per your requirements
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]);
  }

  void openAttachmentWindow() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Set allowMultiple to true
    );


    final externalDirectory = await getExternalStorageDirectory();

    //Get directory path
    final path = externalDirectory?.path;
    if (result != null) {
      // Files picked successfully
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (var file in files) {
        // Copy the file to your application's files directory
        final String fileName = file.path.split('/').last;
        final String newPath = '$path/$fileName';
        final File newFile = await file.copy(newPath);

        // Add the uploaded file to the list
        uploadedFiles.add(newFile);
      }

      // Update the UI to reflect the changes
      setState(() {});
    } else {
      // User canceled the file picking
    }
  }

}
