import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../widgets/follow_button.dart';
import 'login_screen.dart';

class SideMenu extends StatefulWidget {
  final String uid;



  const SideMenu({super.key,  required this.uid, });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var userData = {};
  bool isLoading =false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    setState(() {
      isLoading =true;
    });

    try{
      var userSnap =await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      userData=userSnap.data()!;

      setState(() {});
    }catch(e){
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    //final UserModel? user = Provider.of<UserProvider>(context).getUser;

    return SafeArea(
        child: Drawer(
            child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1678162115265-6a4e74a2b152?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80'
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,) )),

                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                userData['photoUrl'] ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                         Text(
                           userData['username'] ?? '' ,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                           Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              userData['userLocation'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                      ],

                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Winter'),
                    onTap: () => null,
                    trailing: Container(
                      color: Colors.greenAccent,
                      width: 20,
                      height: 20,
                      child: const Center(
                        child: Text('10'),
                      ),
                    ),

                  ),
                  ListTile(
                    leading: const Icon(Icons.cloudy_snowing),
                    title: const Text('Rainy'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: const Icon(Icons.energy_savings_leaf),
                    title: const Text('Leafy'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: const Icon(Icons.sunny),
                    title: const Text('Sunny'),
                    onTap: () => null,
                  ),

                  Divider(),
                  ListTile(
                    title: FirebaseAuth.instance.currentUser!.uid ==
                        widget.uid
                        ? FollowButton(
                      text: 'Sign Out',
                      backgroundColor:
                      Colors.green,
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
                    ):const Text('Error Occured')
                  ),

                ]
            )
        )
    );
  }
}