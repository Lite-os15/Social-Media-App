import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[
      Marker(
        point: LatLng(0, 0),
        builder: (ctx) => Container(

          decoration: const BoxDecoration(
            shape: BoxShape.circle,

            image: DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1686070607952-8fb9e8abc38c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEzfDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.0, 56),
          zoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}',
          ),
          MarkerLayer(
            markers: marker,
          ),
        ],


      ),
    );
  }
}
