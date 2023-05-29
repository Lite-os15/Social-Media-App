import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      userData = userSnap.data()!;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.2;
    final double profileHeight = MediaQuery.of(context).size.height * 0.15;
    final double avatarRadius = 45;

    return Scaffold(
      appBar: AppBar(
        title: Text(userData['username']),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: coverHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1682685797736-dabb341dc7de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(userData['dob']),
                      ],
                    ),
                    const Spacer(),
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? FollowButton(
                      backgroundColor: Colors.lightBlueAccent,
                      borderColor: Colors.greenAccent,
                      text: 'Edit Profile',
                      textColor: Colors.black,
                      function: () {},
                    )
                        : isFollowing
                        ? FollowButton(
                      backgroundColor: Colors.blueGrey,
                      borderColor: Colors.greenAccent,
                      text: 'Unfollow',
                      textColor: Colors.white,
                      function: () {},
                    )
                        : FollowButton(
                      backgroundColor: Colors.yellowAccent,
                      borderColor: Colors.black,
                      text: 'Follow',
                      textColor: Colors.black,
                      function: () {},
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                      child: Icon(Icons.nature),
                    )
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                  right: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: NetworkImage(
                        userData['photoUrl'],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStatItem('Issues', postLen),
                  // buildStatItem('Feeds', feeds),
                  buildStatItem('Following', following),
                  buildStatItem('Followers', followers),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  userData['bio'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.grid_on),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.list_alt),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildStatItem(String label, int num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
