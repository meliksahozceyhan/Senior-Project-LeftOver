import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/DropPoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MapBody());

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  GoogleMapController googleMapController;

  Iterable markers = [];
  Iterable _markers = [];

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(38.98014030289647, 35.07758791483959), zoom: 5);

  void getDropPoints() async {
    Map<String, String> headers = new Map<String, String>();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    headers["Authorization"] = "Bearer " + token;

    final response = await http.get(Uri.parse(dotenv.env['API_URL'] + "/map"),
        headers: headers);

    if (response.statusCode == 500) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text(
            'Something went wrong on the server side',
          ),
          backgroundColor: redCheck,
          action: SnackBarAction(
              label: 'Close',
              onPressed: scaffold.hideCurrentSnackBar,
              textColor: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    var jsonData = jsonDecode(response.body) as List;

    var locations = jsonData.map((e) => e as Map<String, dynamic>)?.toList();

    _markers = Iterable.generate(locations.length, (index) {
      return Marker(
          markerId: MarkerId(locations[index]['id']),
          position: LatLng(
            double.parse(locations[index]['lat']),
            double.parse(locations[index]['lon']),
          ),
          infoWindow: InfoWindow(title: locations[index]["title"]));
    });

    setState(() {
      markers = _markers;
    });
  }

  @override
  void initState() {
    getDropPoints();

    super.initState();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: const Text(
              'If you want to add drop point for recycling items, you need to get in touch with technical staff.\n\n\n phone: 0XXX XXX XX XX\n \ne-mail: techsupport@leftover.com',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          backgroundColor: darkBackgroundColor,
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close',
                    style: TextStyle(color: greenBlockColor))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Drop Point Locations',
          ),
          backgroundColor: darkBackgroundColor,
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  print("Request Item Pressed");
                  _showDialog();
                },
                child: const Text('Add',
                    style: TextStyle(color: lightPinkBlockColor))),
          ],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
          markers: Set.from(markers),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinePosition();

            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 12)));

            //AppConstant.list.add({"title": "currentLocation", "id": "4", "lat": position.latitude, "lon": position.longitude});

            setState(() {
              //markers = _markers;
            });
          },
          label: const Text("Current Location"),
          backgroundColor: darkBackgroundColor,
          icon: const Icon(Icons.location_searching_rounded),
        ),
      ),
    );
  }
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

  return await Geolocator.getCurrentPosition();
}
