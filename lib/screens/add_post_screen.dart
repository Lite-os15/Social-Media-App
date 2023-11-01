import 'dart:io';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import 'feed_screen.dart';

class AddPostScreen extends StatefulWidget {
  final String lat;
  final String long;
  final XFile CameraPic;
  final String Address;

  const AddPostScreen(
      {Key? key,
      required this.CameraPic,
      required this.Address,
      required this.lat,
      required this.long})
      : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState(CameraPic, Address);
}

class _AddPostScreenState extends State<AddPostScreen> {
  var CameraPic;
  var Address;
  final TextEditingController _descriptionController = TextEditingController();
  _AddPostScreenState(this.CameraPic, this.Address);
  bool _isLoading = false;
  late SingleValueDropDownController _cnt;




  @override
  void dispose() {
    _cnt.dispose();

    super.dispose();
  }

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
    String lat,
    String long,
    Uint8List? imageData,
  ) async {
    setState(() {
      _isLoading = true;
    });
    if (uid != null &&
        username != null &&
        profImage != null &&
        Address != null &&
        imageData != null) {
      try {
        String res = await FireStoreMethods().uploadPost(
          _descriptionController.text,
          imageData,
          uid,
          username,
          profImage,
          Address,
          lat,
          long,
        );
        if (res == "success") {
          setState(() {
            _isLoading = false;
          });
          showSnackBar('Posted!', context);
          Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const FeedScreen()));
          Navigator.pop(context);
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
  void clearImage() {
    setState(() {
      _imageData = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _imageData = Uint8List(0);
    _readFile();
    _cnt = SingleValueDropDownController();

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          InkWell(
            child: TextButton(
                onPressed: () {
                  postImage(
                    user!.uid,
                    user.username,
                    user.photoUrl,
                    widget.Address,
                    widget.lat,
                    widget.long,
                    _imageData,
                  );
                  // Navigator.of(context).pop(MaterialPageRoute(builder: (context) => FeedScreen()));
                  //Navigator.pop(context);
                },
                child:
                    const Text('POST', style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0)),

            Row(children: <Widget>[
              const Align(
                heightFactor: 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      maxLength: 500,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Describe the Issue!!!",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ]
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: DropDownTextField(
                // initialValue: "name4",
                controller: _cnt,
                clearOption: true,
                // enableSearch: true,
                // dropdownColor: Colors.green,
                searchDecoration: const InputDecoration(
                    hintText: "enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: 6,

                dropDownList: const [
                  DropDownValueModel(name: 'Waste', value: "Waste"),
                  DropDownValueModel(
                      name: 'Street Light',
                      value: "Street Light",
                      ),
                  DropDownValueModel(name: 'Potholes', value: "Potholes"),
                  DropDownValueModel(
                      name: 'Air Pollution',
                      value: "Air Pollution",
                      ),
                  DropDownValueModel(name: 'Public Places', value: "Public Places"),
                  DropDownValueModel(name: 'Others', value: "Others"),

                ],
                onChanged: (val) {},
              ),
            ),



            const Divider(),


                Container(
                  height: size.height / 2.0,
                  width: double.infinity,
                  // color: Colors.pinkAccent,
                  child: Image.file(File(CameraPic.path)),
                ),




            // Container(
            //
            //   height: size.height /2.2,
            //   color: Colors.pinkAccent,
            //   child: Image.file(File(CameraPic.path)),
            // ),

            Chip(
              avatar: const Icon(Icons.location_on_outlined),
              label: Text(Address),
              labelStyle: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
