import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? _currentPosition;
  String _currentLocality = "";

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // Determine the current device's position
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Latitude: ${_currentPosition?.latitude}',
              ),
              Text(
                'Longitude: ${_currentPosition?.longitude}',
              ),
              Text(
                'Locality: $_currentLocality',
              ),
            ],
          ),
        ),
      ),
    );
  }
}