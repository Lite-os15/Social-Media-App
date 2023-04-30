import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const UserModel(
      {required this.username,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.bio,
        required this.followers,
        required this.following});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data();
    if (snapshot == null)
      return UserModel(
        username:"",
        uid:"",
        email:"",
        photoUrl:"",
        bio:"",
        followers:[],
        following:[],

    );


      //throw Exception("DocumentSnapshot data is nul!");



    return UserModel(
      username: snap["username"],
      uid: snap["uid"],
      email: snap["email"],
      photoUrl: snap["photoUrl"],
      bio: snap["bio"],
      followers: snap["followers"],
      following: snap["following"],
    );
    // return UserModel(
    //   username: "username",
    //   uid: "uid",
    //   email: "email",
    //   photoUrl: "photoUrl",
    //   bio: "bio",
    //   followers:["followers"],
    //   following: ["following"],
    // );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,
  };
}
