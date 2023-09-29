import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class IntroScreen extends StatefulWidget {
  final String email;
  final String password;
  final String bio;
  final String username;
  final Uint8List imageFile;

  const IntroScreen({
    Key? key,
    required this.email,
    required this.password,
    required this.bio,
    required this.username,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _location = TextEditingController();

  double lat = 0.0;
  double long = 0.0;
  bool _isLoading = false;

  void signUpUser() async {
    if (_date.text.isNotEmpty && _location.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String res = await AuthMethods().signUpUser(
        email: widget.email,
        password: widget.password,
        username: widget.username,
        bio: widget.bio,
        file: widget.imageFile,
        dob: _date.text,
        userLocation: _location.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (res == "success") {
        // navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      } else {
        showSnackBar(res, context);
      }
    }
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address = placemark.locality ?? '';
      _location.text = address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1684399026406-da824e064d46?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=1000&q=60',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: const Text(
                'Enter Your Birth Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickdate != null) {
                    setState(() {
                      _date.text =
                          DateFormat('dd MMMM yyyy').format(pickdate);
                    });
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _date,
                    decoration: const InputDecoration(
                      icon: Icon(
                        CupertinoIcons.calendar,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Select Date',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    enabled: false,
                    validator: (value) {
                      if (value == null) {
                        return 'please enter username';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                getLocation();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _location,
                  decoration: const InputDecoration(
                    icon: Icon(
                      CupertinoIcons.location_solid,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Your Area',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'please enter location';
                    }
                    return null;
                  },
                  enabled: false,
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_date.text.isEmpty || _location.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select date and location"),
                    ),
                  );
                } else {
                  signUpUser();
                }
              },
              child: const Text("Let's change"),
            ),
          ],
        ),
      ),
    );
  }
}
