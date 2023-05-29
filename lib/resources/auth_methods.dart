import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // get user details
  Future<UserModel?> getUserDetails() async {
    User? currentUser = _auth.currentUser!;

    if (currentUser == null) {
      throw Exception("User not found");
    }

    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('users')
        .doc(currentUser.uid)
        .get();


    return UserModel.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        UserModel _user = UserModel(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          dob: '',
          following: [],

        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }


  // User date of birth
  Future<String> userDOB({
    required String dob,
  }) async {
    String res = "Some error Occurred";
    try {
      if (dob.isNotEmpty) {
        User? currentUser = _auth.currentUser;
        if (currentUser == null) {
          throw Exception("User not found");
        }

        // Create a Map object with the 'dob' field
        Map<String, dynamic> userData = {
          'dob': dob,
        };

        // Update the user's data in the Firestore collection
        await _firestore.collection("users").doc(currentUser.uid).update(userData);

        res = "success";
      } else {
        res = "Please enter birth date";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }







  Future<void> signOut() async {
    await _auth.signOut();
  }

}
