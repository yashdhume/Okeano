import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMaps createState() => _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(43.944459, -78.896443);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 10.0,
      ),
    );
  }
}
