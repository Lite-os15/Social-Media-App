import 'package:Lets_Change/resources/firestore_methods.dart';
import 'package:Lets_Change/screens/edit_profile.dart';
import 'package:Lets_Change/screens/qr_screen.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:Lets_Change/widgets/follow_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../resources/auth_methods.dart';
import 'login_screen.dart';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.2;
    final double profileHeight = MediaQuery.of(context).size.height * 0.06;
    const double avatarRadius = 45;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(userData['username']! ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile())),
                child: Icon(Icons.edit)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRScreen())),
                child: Icon(CupertinoIcons.qrcode)),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
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
                Positioned(
                  top: coverHeight - avatarRadius,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Container(
                      height:avatarRadius * 2,
                      width: avatarRadius * 2,
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        image: DecorationImage(fit: BoxFit.cover,
                          image: NetworkImage(userData['photoUrl'] ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=')
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:Colors.white,width: 3
                        )
                      ),
                      // radius: avatarRadius,
                      // backgroundColor: Colors.grey.shade800,
                      // backgroundImage: NetworkImage(
                      //   userData['photoUrl'] ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
                      // ),
                    ),
                  ),
                ),
              ],
            ),

              SizedBox(height: avatarRadius,),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:[Colors.green, Colors.lightGreenAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,

                  )
                ),
                // color: Colors.lightBlueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child:
                    // ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['username'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(userData['dob'] ?? ''),
                      ],
                    ),
                    const Spacer(),
                    FirebaseAuth.instance.currentUser!.uid ==
                        widget.uid
                        ? FollowButton(
                      text: 'Sign Out',
                      backgroundColor:
                      Colors.black12,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      function: () async {
                        await AuthMethods().signOut();
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginScreen(),
                          ),
                        );
                      },
                    )
                        : isFollowing
                        ? FollowButton(
                      text: 'Unfollow',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      function: () async {
                        await FireStoreMethods()
                            .followUser(
                          FirebaseAuth.instance
                              .currentUser!.uid,
                          userData['uid'],
                        );

                        setState(() {
                          isFollowing = false;
                          followers--;
                        });
                      },
                    )
                        : FollowButton(
                      text: 'Follow',
                      backgroundColor: Colors.blue,
                      textColor: Colors.black,
                      borderColor: Colors.blue,
                      function: () async {
                        await FireStoreMethods()
                            .followUser(
                          FirebaseAuth.instance
                              .currentUser!.uid,
                          userData['uid'],
                        );

                        setState(() {
                          isFollowing = true;
                          followers++;
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                      child: Icon(CupertinoIcons.tree,color: Colors.green,),
                    )
                  ],
                ),
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
                  userData['bio'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.grid_on),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.list_alt),
                    onPressed: () {},
                  ),
                )
              ],
            ),
    const Divider(),
                 FutureBuilder(
    future: FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .get(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }

    return GridView.builder(
      shrinkWrap: true,
      itemCount: (snapshot.data! as dynamic).docs.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 1.5,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        DocumentSnapshot snap =
        (snapshot.data! as dynamic).docs[index];

        return Container(
          child: Image(
            image: NetworkImage(snap['postUrl']),
            fit: BoxFit.cover,
          ),
        );
      },
    );
    },
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
