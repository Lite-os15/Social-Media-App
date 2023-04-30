import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';


class AddPostScreen extends StatefulWidget {
  var CameraPic;
  var Address;
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

  void postImage(
      String uid,
      String username,
      String profImage,
      )async{
     try {

     }catch(e){

     }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserModel? user =Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Create Post'),
        
        actions: [
          TextButton(
              onPressed: (){},
              child: Text('POST',style: TextStyle(color: Colors.white)
          )
          ),
        ],
      ),
       body:
      Column(
        children: [
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






      // Column(
      //   children:[
      //     Container(
      //         width: double.infinity,
      //         height: 200,
      //         child: Image.file(File(CameraPic.path))),
      //      Text(Address)
      //   ],
      //  ),

     // ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('CameraPic', CameraPic));
  }
}
