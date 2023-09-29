
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

    return SafeArea(
      child: Scaffold(
      


        body: (_position == null) ? const Center(child: CircularProgressIndicator(),): Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(_position!.latitude, _position!.longitude),
                zoom: 17.0,
              ),
              children: [
                TileLayer(
                  // THE URL FOR OpenStreetView API.
                  urlTemplate:
                  "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                // subdomains: const ["a","b","c"],
                ),
                MarkerLayer(
                  markers: markerList,
                ),
              ],
            ),
            Column(mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,size: 30,),
                     fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),

                    ),
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,12,8),
                      child: CircleAvatar(backgroundColor: Colors.white,
                          child: Icon(CupertinoIcons.layers_alt_fill,color: Colors.black,)),
                    )),
                Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,12,8),
                      child: CircleAvatar(backgroundColor: Colors.white,
                          child: Tooltip(
                            message: 'Coming Soon!!!',
                              triggerMode: TooltipTriggerMode.tap,
                              child: Icon(CupertinoIcons.tree,color: Colors.green,))),
                    )),
              ],
            ),


            //Bottom List View
            Align(alignment: Alignment.bottomCenter,
              child: Container(

                height: 100, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Number of Containers in the list
                  itemBuilder: (context, index) {
                    // Replace this with the content you want in each Container
                    return InkWell(
                      onTap: (){_issueBottomSheet(context);},
                      child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                        width: MediaQuery.of(context).size.width*0.6,
                        margin: EdgeInsets.all(8),

                        child: Row(

                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 25,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Type Of Issue'),
                                Divider(),
                                Text('Location'),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.leaf_arrow_circlepath),
                                Text('No. of Change'),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> getCurrentPos() async {
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

  Future<void> getPostData() async {
    await FirebaseFirestore.instance.collection('posts').snapshots().forEach((element) {
      //THIS FOR LOOP RUNS TO FETCH THE LAT AND LONG OF EACH POST AND CREATE A MARKER AND ADD IT TO markerLIST VARIABLE.
      for(int i=0;i<element.size;i++) {
        var snapshot = element.docs[i].data();
        var marker = Marker(
          width: 50,height: 50,
          point: LatLng(19.0760,72.8777
              // snapshot['lat'], snapshot['long']
          ),
          builder: (ctx) => InkWell(
            onTap: () {_issueBottomSheet(context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //         content:
              //         Text(
              //             'Post UID : ${snapshot['postId']} clicked')));
              //
              // print('${snapshot['postId']} clicked');
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


  void _issueBottomSheet(BuildContext context){
    showModalBottomSheet(shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35)
    ),
        context: context,
        builder: (BuildContext context)
        {
          return Column(
            children: [
            SizedBox(height: 40,),
              Container(
                
              )
            ],
          );
        }
    );

  }

}
