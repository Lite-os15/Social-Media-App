import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'add_post_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  int direction = 0;
  double? lat;

  double? long;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) async {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      List<Placemark> placemarks =
      await placemarkFromCoordinates(value.latitude, value.longitude);
      setState(() {
        String address =
            "${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea!}";
      });
    }).catchError((error) {
      print("Error $error");
    });
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const SizedBox();
    }
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(cameraController!),
          GestureDetector(
            onTap: () {
              setState(() {
                direction = direction == 0 ? 1 : 0;
                startCamera(direction);
              });
            },
            child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
          ),
          GestureDetector(
            onTap: () async {
              await cameraController!
                  .takePicture()
                  .then((XFile? file) async {
                Uint8List bytes = await file!.readAsBytes();

                if (mounted) {
                  if (file != null) {
                    _determinePosition().then((value) async {
                      List<Placemark> placemarks =
                      await placemarkFromCoordinates(
                          value.latitude, value.longitude);

                      String address =
                          "${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}";
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AddPostScreen(
                            CameraPic: file,
                            Address: address,
                            lat: value.latitude.toString(),
                            long: value.longitude.toString(),
                          ),
                        ),
                      );
                    });
                    print("Print saved to ${file.path}");
                  }
                }
              });
            },
            child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
                backgroundColor: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}