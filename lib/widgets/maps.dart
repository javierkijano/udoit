import 'dart:async';
import 'dart:math';

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
  LatLng min_area;
  LatLng max_area;
  double delta_lat;
  double delta_lng;

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
    min_area = LatLng(41.38669257741156, 2.169411536650914);
    max_area = LatLng(41.38745727220532, 2.1704844202406623);
    delta_lat = max_area.latitude - min_area.latitude;
    delta_lng = max_area.longitude - min_area.longitude;
    for (int i = 0; i < 10; i++) {
      _markers.add(Marker(
        markerId: MarkerId('user_${i.toString()}'),
        position: LatLng(min_area.latitude + Random().nextDouble() * delta_lat,
            min_area.longitude + Random().nextDouble() * delta_lng),
      ));
    }
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
      void handleTimeout(Timer timer) {
        _markers = _markers.map((marker) {
          print(marker.toJson());
          return Marker(
            markerId: marker.markerId,
            position: LatLng(
                marker.position.latitude +
                    delta_lat / 20 * pow(-1, Random().nextInt(2)),
                marker.position.longitude +
                    delta_lng / 20 * pow(-1, Random().nextInt(2))),
          );
        });
      }

      Timer.periodic(Duration(milliseconds: 500), handleTimeout);
    });
    //controller.animateCamera(CameraUpdate.newCameraPosition(_kPosition));
  }
}
