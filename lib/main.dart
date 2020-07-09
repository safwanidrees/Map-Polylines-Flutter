import 'package:flutter/material.dart';
import 'package:map_polyline_flutter/provider/location_provider.dart';
import 'package:map_polyline_flutter/screen/dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: LocationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: DashBoardPage(),
        ));
  }
}
