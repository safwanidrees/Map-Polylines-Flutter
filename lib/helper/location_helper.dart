import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const API_KEY = "YOUR API KEY";

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$API_KEY";
    final responce = await http.get(url);
    return json.decode(responce.body)['results'][0]['formatted_address'];
  }
   Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
      String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$API_KEY";
      http.Response response = await http.get(url);
      Map values = jsonDecode(response.body);
      return values["routes"][0]["overview_polyline"]["points"];
    }
}
