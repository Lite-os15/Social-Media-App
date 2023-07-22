
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Position? _position;
  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();
    //THIS FUNCTION FETCHES ALL THE POST DATA FROM FIRESTORE
    getPostData();
    // THIS FUNCTION GET THE CURRENT LOCATION OF THE USER
    getCurrentPos();
  }

  @override
  Widget build(BuildContext context) {
    // var markerList = <Marker>[
    //   Marker(
    //     width: 50,height: 50,
    //     point: (_position == null) ? LatLng(34.7, 50):LatLng(_position!.latitude, _position!.longitude),
    //     builder: (ctx) => InkWell(
    //       onTap: () {
    //         print('marker clicked');
    //       },
    //       child: Container(
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(width: 3.0,color: Colors.white),
    //           image: DecorationImage(
    //             scale: 2.0,
    //             image: NetworkImage('https://images.unsplash.com/photo-1686070607952-8fb9e8abc38c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEzfDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: (_position == null) ? const Center(child: CircularProgressIndicator(),): FlutterMap(
        options: MapOptions(
          center: LatLng(_position!.latitude, _position!.longitude),
          zoom: 17.0,
        ),
        children: [
          TileLayer(
            // THE URL FOR OpenStreetView API.
            urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ["a","b","c"],
          ),
          MarkerLayer(
            markers: markerList,
          ),
        ],


      ),
    );
  }

 Future<void> getCurrentPos() async {
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = pos;
    });
 }

  Future<void> getPostData() async {
    await FirebaseFirestore.instance.collection('posts').snapshots().forEach((element) {
      //THIS FOR LOOP RUNS TO FETCH THE LAT AND LONG OF EACH POST AND CREATE A MARKER AND ADD IT TO markerLIST VARIABLE.
      for(int i=0;i<element.size;i++) {
        var snapshot = element.docs[i].data();
        var marker = Marker(
          width: 50,height: 50,
          point: LatLng(snapshot['lat'], snapshot['long']),
          builder: (ctx) => InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(
                          'Post UID : ${snapshot['postId']} clicked')));

              print('${snapshot['postId']} clicked');
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3.0,color: Colors.white),
                image: DecorationImage(
                  scale: 2.0,
                  image: NetworkImage(snapshot['postUrl']),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
        markerList.add(marker);
      }
    });
  }
}
