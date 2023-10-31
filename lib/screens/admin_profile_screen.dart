import 'package:Lets_Change/resources/auth_methods.dart';
import 'package:Lets_Change/screens/edit_profile.dart';
import 'package:Lets_Change/screens/login_screen.dart';
import 'package:Lets_Change/screens/qr_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/follow_button.dart';




class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.2;
    final double profileHeight = MediaQuery.of(context).size.height * 0.06;
    const double avatarRadius = 45;


    return SafeArea(
        child: Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Username"),
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
          child: GestureDetector(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

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
                      child: Container(
                        alignment: Alignment.center,
                        height:avatarRadius * 2,
                        width: avatarRadius * 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,

                            image: DecorationImage(fit: BoxFit.cover,
                                image: NetworkImage('https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=')
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "UserName",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Date of Birth"),
                          ),
                        ],
                      ),
                      const Spacer(),

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
                      buildStatItem('Issues', 50),
                      // buildStatItem('Feeds', feeds),
                      buildStatItem('Following', 30),
                      buildStatItem('Followers', 100),
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
                      "'Describe about yourself'",
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
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {


                    return Container(
                      child: Image(
                        image: NetworkImage('https://images.unsplash.com/photo-1688408958818-87ab7f118246?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80'),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )

              ],

            ),
          ),

        ),

      ),
    ));
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
