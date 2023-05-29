import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'add_post_screen.dart';



class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;
  late double lat,long;



  @override
  void initState() {
    startCamera(0);
    super.initState();

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) async {
      print("value $value");
      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);
      setState(() {
        String address = "${placemarks[0].subAdministrativeArea!} ,  ${placemarks[0].administrativeArea!}";
      });

    }).catchError((error) {
      print("Error $error");
    });
  }
  //For convert lat long to address
  // getAddress(lat, long) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  //   setState(() {
  //
  //   });
  //
  //   for (int i = 0; i < placemarks.length; i++) {
  //     print("INDEX $i ${placemarks[i]}");
  //   }
  // }

  void startCamera(int directon) async {
    cameras = await availableCameras();

    cameraController = CameraController(
        cameras[direction],
        ResolutionPreset.high,
        enableAudio: false,
    );
    await cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {}); //To refresh Widget
    }).catchError((e){
      print(e);
    });
  }
  @override
  void dispose() {
    // cameraController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {


    if (cameraController == null || !cameraController.value.isInitialized) {
      return const SizedBox();
    }
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: (){
                setState(() {
                  direction = direction == 0 ? 1:0;
                  startCamera(direction);
                });
              },
                child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft)
            ),
            GestureDetector(

    onTap:() async {

                  await cameraController.
                  takePicture().
                  then((XFile? file)
                  async {
                    Uint8List bytes = await file!.readAsBytes();

                      if(mounted){
                        if(file != null)
                        {
                          _determinePosition().then((value) async {
                            List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);

                            String address = "${placemarks[0].locality !} , ${placemarks[0].administrativeArea!}";
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddPostScreen(CameraPic: file, Address: address, )));
                          });
                          print("Print saved to ${file.path}");
                          // Navigator.of(context).pop();

                        }
                      }

                });
                },
                child: button(Icons.camera_alt_outlined, Alignment.bottomCenter)
            ),
           Align(
             alignment: Alignment.topLeft,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
                   child: FloatingActionButton( onPressed: (){
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
  Widget button(IconData icon,Alignment alignment){
    return  Align(
      alignment: alignment,
      child: Container(
        margin:  const EdgeInsets.only(
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
            ]
        ),
        child: Center(
          child: Icon(
            icon,
            color:Colors.black ,


          ),
        ),
      ),
    );




  }

  }
