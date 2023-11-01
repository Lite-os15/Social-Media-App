import 'package:Lets_Change/screens/about_screen.dart';
import 'package:Lets_Change/screens/change_password.dart';
import 'package:Lets_Change/screens/feedback_screen.dart';
import 'package:Lets_Change/screens/group_screen.dart';
import 'package:Lets_Change/screens/notification_screen.dart';
import 'package:Lets_Change/screens/profile_screen.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  Position? _currentPosition;
  String _currentLocality = "";

  bool _isBlinking = true;
  Color _chipColor = Colors.red; // Initial color is red

  @override
  void initState() {
    super.initState();
    _determinePosition();
    getData();

    // Start the blinking animation
    startBlinking();
  }

  void startBlinking() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isBlinking = !_isBlinking;
          _chipColor = _isBlinking ? Colors.red : Colors.yellow ;
        });
        startBlinking();
      }
    });
  }



  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied permanently, handle accordingly.
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Reverse geocode the position to get address information
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Extract the locality (city) from the placemarks
    String locality = "${placemarks[0].street},${placemarks[0].postalCode},${placemarks[0].locality}${placemarks[0].administrativeArea}" ?? "N/A";

    // Update state with the current position and locality
    setState(() {
      _currentPosition = position;
      _currentLocality = locality;
    });
  }







  getData() async{
    setState(() {
      isLoading =true;
    });

    try{
      var userSnap =await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      userData=userSnap.data()!;

      setState(() {});
    } catch(e){
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });

  }


  //Combination for Gradient
  List<List<Color>> _gradientCombinations = [
    [Colors.red, Colors.orange],
    [Colors.purple, Colors.blue],
    [Colors.lightBlueAccent, Colors.teal],
    [Colors.yellow, Colors.pink],
    [Colors.deepPurple, Colors.pinkAccent]
  ];
  int _currentColorIndex = 0;

  void _changeGradient() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % _gradientCombinations.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final UserModel? user = Provider.of<UserProvider>(context).getUser;

    return SafeArea(
        child: Drawer(
            child: ListView(
                children: [
                  GestureDetector(
                    onTap: _changeGradient,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration:  BoxDecoration(
                        gradient: LinearGradient(
                          colors: _gradientCombinations[_currentColorIndex],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: NetworkImage(
                        //       'https://images.unsplash.com/photo-1678162115265-6a4e74a2b152?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80'
                        //   ),
                        // ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,) )),

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
                             userData['username'] ?? 'Network Error' ,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),

                          AnimatedContainer(
                            decoration: BoxDecoration(
                                // color: _chipColor,
                            borderRadius: BorderRadius.circular(25)
                          ),
                            duration: Duration(seconds: 1),

                            child: Chip(
                              backgroundColor: _chipColor,
                              avatar: Icon(Icons.location_on_outlined),
                              label: Text(
                                '$_currentLocality',

                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],

                      ),
                    ),
                  ),
                  ListTile(
                    title: FirebaseAuth.instance.currentUser!.uid ==
                        widget.uid
                        ? FollowButton(
                      text: 'Sign Out',
                      backgroundColor:
                      Colors.green,
                      textColor: Colors.grey.shade200,
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