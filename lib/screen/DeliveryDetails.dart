import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_flutter/helper/location_helper.dart';
import 'package:map_polyline_flutter/provider/location_provider.dart';

import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  LatLng userPlace;
  LatLng destination;
  DeliveryDetails({
    @required this.userPlace,
    @required this.destination,
  });

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  GoogleMapController mapController;

  String address = '';

  Completer<GoogleMapController> _controller = Completer();

  Future<void> getData() async {
    address = await LocationHelper.getPlaceAddress(
        widget.destination.latitude, widget.destination.longitude);
    print(address);

    await Provider.of<LocationProvider>(context, listen: false).sendRequest(
        LatLng(widget.userPlace.latitude, widget.userPlace.longitude),
        LatLng(widget.destination.latitude, widget.destination.longitude),
        address);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.userPlace.latitude, widget.userPlace.longitude),
            zoom: 12),
        mapType: MapType.normal,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller.complete(controller);
            getData();
          });
        },
        markers: data.markers,
        onCameraMove: data.onCameraMove,
        polylines: data.polyLines,
      ),
    );
  }
}
