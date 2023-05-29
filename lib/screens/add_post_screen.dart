import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';


class AddPostScreen extends StatefulWidget {

  final XFile CameraPic;
  final String Address;

  AddPostScreen({Key? key, required this.CameraPic, required this.Address})
      : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState(CameraPic, Address);
}

class _AddPostScreenState extends State<AddPostScreen> {
  var CameraPic;
  var Address;
  final TextEditingController  _descriptionController =TextEditingController();
  _AddPostScreenState(this.CameraPic, this.Address);
  bool _isLoading = false;

  Uint8List? _imageData;

  Future<void> _readFile() async {
    final file = File(CameraPic!.path);
    _imageData = await file.readAsBytes();
  }

  // List<int> bytes = File(CameraPic).readAsBytesSync();
  void postImage(
      String? uid,
      String? username,
      String? profImage,
      String? Address,
      Uint8List? imageData,

      )async{
        setState(() {
          _isLoading = true ;
        });
        if (uid != null && username != null && profImage != null && Address != null && imageData != null) {
          try {
            String res = await FireStoreMethods().uploadPost(
              _descriptionController.text,
              imageData,
              uid,
              username,
              profImage,
              Address,
            );
            if (res == "success") {
              setState(() {
                _isLoading = false;
              });
              showSnackBar('Posted!', context);
             // Navigator.pop(context);
              Navigator.of(context).pop(MaterialPageRoute(builder: (context) => FeedScreen()));
            } else {
              setState(() {
                _isLoading = false;
              });
              showSnackBar(res, context);
            }
          } catch (e) {
            showSnackBar(e.toString(), context);
          }
        } else {
          showSnackBar('One or more required values are null', context);
        }
  }
  //In this updated code, all the variables (uid, username, profImage, address, and imageData) are marked as nullable (String? and Uint8List?). Inside the method, before accessing these variables, we check if any of them are null. If any of them is null, we show a snackbar indicating that some required values are null. Otherwise, we proceed with the post upload process.

  //Make sure to update the method signature and null checks wherever you're calling the postImage method.






  //clear the image and return to the screen back
  void clearImage(){
    setState(() {
      _imageData =null;
    });

  }
  @override
  void initState() {
    super.initState();
    _imageData = Uint8List(0);
    _readFile();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   final UserModel? user =Provider.of<UserProvider>(context).getUser;


    return Scaffold(
      appBar: AppBar(

        title: const Text('Create Post'),

        actions: [
          InkWell(
            child: TextButton(
                onPressed:  () {
                  postImage(
                  user!.uid,
                  user.username,
                  user.photoUrl,
                  widget.Address,
                  _imageData,
                  );
                 // Navigator.of(context).pop(MaterialPageRoute(builder: (context) => FeedScreen()));
              //Navigator.pop(context);
  },
                child: const Text('POST',style: TextStyle(color: Colors.white)
            )
            ),
          ),
        ],
      ),
       body:
      Column(
        children: [
          _isLoading? const LinearProgressIndicator() :
          const Padding(
              padding: EdgeInsets.only(top:0)
          ),
          const Divider(),
          Row(
          children:<Widget>[
            const Align(heightFactor: 0,
              child: Align(alignment: Alignment.topLeft,
                child: CircleAvatar(radius: 30,
                  backgroundColor: Colors.greenAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Describe the Issue!!!",
                     focusedBorder: OutlineInputBorder() ,
                  ),

                ),
              ),
            ),
          ]
           ),


          const Divider(),

          Container(
            height: size.height /2.2,
            color: Colors.pinkAccent,
            child: Image.file(File(CameraPic.path)),
          ),

          Container(
            child: Chip(
              avatar: const Icon(Icons.location_on_outlined),
              label: Text(Address),labelStyle: TextStyle(color: Colors.black87),
            ),
          ),
        ],
    ),

    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('CameraPic', CameraPic));
  }
}
