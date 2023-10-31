import 'dart:io';
import 'dart:typed_data';

import 'package:Lets_Change/screens/Issue_solve_screen.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReplyPostScreen extends StatefulWidget {
  final  snap; // Change 'snap' data type to 'dynamic'
  const ReplyPostScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<ReplyPostScreen> createState() => _ReplyPostScreenState();
}

class _ReplyPostScreenState extends State<ReplyPostScreen> {
  Uint8List? _file;
  var photo;
  File? _image;

  bool _isLoading = false;

  // Declare _selectImage as an async method
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.camera);

                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
            ),

            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply Post'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => IssueSolveScreen( snap: widget.snap)));
              },
            child: Text('REPLY', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_image != null)
              ?Container(width: double.infinity,
              height: 500,decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25)
            ),
                child: Image.file(
                  _image!,

                ),
              ):
            ElevatedButton(
              onPressed: () {
                _selectImage(context); // Call _selectImage
              },
              child: Text('Reply the Issue'),
            ),
          ],
        ),
      ),
    );
  }
}
