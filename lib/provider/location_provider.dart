import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_polyline_flutter/helper/location_helper.dart';

class LocationProvider with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  LocationHelper _locationHelper = LocationHelper();
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;
  LocationHelper get googleMapsServices => _locationHelper;
  GoogleMapController get mapController => _mapController;
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  bool locationServiceActive = true;

  //if you want get your current location
  Future<void> getCurrentLocation() async {
    final position = await Location().getLocation();

    _initialPosition = LatLng(position.latitude, position.longitude);

    notifyListeners();
  }

  // SEND REQUEST
  Future<void> sendRequest(
      LatLng userLocation, LatLng intendedLocation, String address) async {
    LatLng destination =
        LatLng(intendedLocation.latitude, intendedLocation.longitude);
    _addMarker(userLocation, destination, address);
    String route = await _locationHelper.getRouteCoordinates(
        userLocation, destination);

    createRoute(route);
    notifyListeners();
  }

//TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 3,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  List _decodePoly(String poly) {
    var list1 = poly.codeUnits;
    var list2 = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list1[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      //if value is negative then bitwise not the value
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      list2.add(result1);
    } while (index < len);

//Adding to previous value as done in encoding
    for (var i = 2; i < list2.length; i++) list2[i] += list2[i - 2];

    print(list2.toString());

    return list2;
  }

  // ADD A MARKER ON THE MAP
  void _addMarker(LatLng user, LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: "My Destination", snippet: "Destination"),
        icon: BitmapDescriptor.defaultMarker));

    _markers.add(Marker(
        markerId: MarkerId("marker2"),
        position: user,
        infoWindow: InfoWindow(title: address, snippet: "User Home"),
        icon: BitmapDescriptor.defaultMarker));

    notifyListeners();
  }


  List<LatLng> _convertToLatLng(List pointsList) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < pointsList.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(pointsList[i - 1], pointsList[i]));
      }
    }
    return result;
  }


  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }


  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }
}
