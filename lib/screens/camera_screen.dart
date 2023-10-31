import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'add_post_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  double? lat;
  double? long;

  final ImagePicker _picker = ImagePicker();

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
      desiredAccuracy: LocationAccuracy.high,
    );
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



  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? imagefile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear, // Rear camera

      );

      if (imagefile != null) {

        var file =await ImageCropper().cropImage(sourcePath: imagefile.path,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
        if(file != null){

        // Uint8List bytes = await file.readAsBytes();
        _determinePosition().then((value) async {
          List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);

          String address =
              "${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}";
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddPostScreen(
                CameraPic: imagefile,
                Address: address,
                lat: value.latitude.toString(),
                long: value.longitude.toString(),
              ),
            ),
          );
          print("Print saved to ${imagefile.path}");
        });
      }
    }
    }catch (e) {
      print("Error picking image: $e");
    }
  }





  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? imagefile = await _picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear, // Rear camera

      );

      if (imagefile != null) {

        // var file =await ImageCropper().cropImage(sourcePath: imagefile.path,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
        // if(file != null) {



            // Uint8List bytes = await file.readAsBytes();
            _determinePosition().then((value) async {
              List<Placemark> placemarks =
              await placemarkFromCoordinates(value.latitude, value.longitude);

              String address =
                  "${placemarks[0].locality!}, ${placemarks[0]
                  .administrativeArea!}";
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      AddPostScreen(
                        CameraPic: imagefile,

                        Address: address,
                        lat: value.latitude.toString(),
                        long: value.longitude.toString(),
                      ),
                ),
              );
              print("Print saved to ${imagefile.path}");
            });

        // }
      }
    }catch (e) {
      print("Error picking image: $e");
    }
  }


  Future<void> _pickVideoFromCamera() async {
    try {
      final XFile? videoFile = await _picker.pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear, // Rear camera
        maxDuration: const Duration(seconds: 30), // Maximum video duration
      );

      if (videoFile != null) {
        Uint8List bytes = await videoFile.readAsBytes();
        _determinePosition().then((value) async {
          List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);

          String address =
              "${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}";
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddPostScreen(
                CameraPic: videoFile,
                Address: address,
                lat: value.latitude.toString(),
                long: value.longitude.toString(),
              ),
            ),
          );
          print("Video saved to ${videoFile.path}");
        });
      }
    } catch (e) {
      print("Error capturing video: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Center(
        child: Card(
          elevation: 15,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(onPressed: _pickVideoFromCamera, child: Text('Take a Video')),
              ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: _pickImageFromCamera,

                      child: Text('Take a Picture'),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _pickImageFromGallery,

                  child: Text('Pick From Gallery'),
                ),
              ),
            ],
          ),
        )


        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(onPressed: _pickVideoFromCamera, child: Text('Take a Video')),
        //     SizedBox(height: 20),
        //     ElevatedButton(
        //       onPressed: _pickImageFromCamera,
        //       onLongPress: _pickVideoFromCamera,
        //       child: Text('Take a Picture'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
