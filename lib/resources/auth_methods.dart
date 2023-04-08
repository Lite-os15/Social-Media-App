import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

    // get user details
    // Future<model.User> getUserDetails() async {
    // User currentUser = _auth.currentUser!;  //signup user
   Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,


  })async{
    String res ="Some error Occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty ||username.isNotEmpty ||bio.isNotEmpty){
        //register user
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       print(cred.user!.uid);

        String photoUrl = StorageMethods().uploadImageToStorage('profilePics', file, false) as String;
        // add user to database
          await _firestore.collection('users').doc(cred.user!.uid).set({

          'username':username,
          'uid':cred.user!.uid,
          'email':email,
          'bio':bio,
          'followers':[],
          'following':[],
            'photoUrl':photoUrl,
        });

        res ="success";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
}