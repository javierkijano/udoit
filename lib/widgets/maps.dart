import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kSpain = CameraPosition(
    target: LatLng(40.417089751468126, -3.703547775816507),
    zoom: 10,
  );

  static final CameraPosition _kPosition = CameraPosition(
      bearing: 90.0,
      target: LatLng(41.38750747103278, 2.170584352959006),
      tilt: 60,
      zoom: 18);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          /*pinLocationIcon = await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              'assets/destination_map_marker.png');*/
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId('hola'),
              position: LatLng(41.38750747103278, 2.170584352959006),
            ));
            //icon: pinLocationIcon));
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToPosition,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToPosition() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('hola1'),
        position: LatLng(41.38651548883045, 2.1700552665479913),
      ));
      //icon: pinLocationIcon));
    });
    //controller.animateCamera(CameraUpdate.newCameraPosition(_kPosition));
  }
}
