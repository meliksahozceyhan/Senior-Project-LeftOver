import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:left_over/constants.dart';

void main() => runApp(MapBody());

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
  }

class _MapBodyState extends State<MapBody> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
      markerId: MarkerId(AppConstant.list[index]['id']),
      position: LatLng(
        AppConstant.list[index]['lat'],
        AppConstant.list[index]['lon'],
      ),
      infoWindow: InfoWindow(title: AppConstant.list[index]["title"])
    );
  });



  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drop Point Locations'),
          backgroundColor: lilacColor,
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(38.98014030289647, 35.07758791483959), zoom: 5),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        ),
      ),
    );
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "one", "id": "1", "lat": 39.87131091583955, "lon": 32.76398929469355},
    {"title": "two", "id": "2", "lat": 39.87262541026877, "lon": 32.750727784323836},
    {"title": "three", "id": "3", "lat": 39.865384176743355, "lon": 32.743189640041855},
  ];
}