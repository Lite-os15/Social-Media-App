import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String dob;


  const UserModel(
      {required this.username,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.bio,
        required this.followers,
        required this.following,
        required this.dob,
      });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data();
    if (snapshot == null) {
      return const UserModel(
        username:"",
        uid:"",
        email:"",
        photoUrl:"",
        bio:"",
        followers:[],
        following:[], dob: "",


    );
    }


      //throw Exception("DocumentSnapshot data is nul!");



    return UserModel(
      username: snap["username"],
      uid: snap["uid"],
      email: snap["email"],
      photoUrl: snap["photoUrl"],
      bio: snap["bio"],
      followers: snap["followers"],
      following: snap["following"], dob: snap["dob"],

    );

  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "dob": dob,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,

  };
}
