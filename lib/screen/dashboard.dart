import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_flutter/screen/DeliveryDetails.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  //AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: new ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DeliveryDetails(
                    userPlace: LatLng(24.92487147, 67.03366959),
                    destination: LatLng(24.96284984, 67.06731522),
                  );
                }),
              );
            },
            child: Container(
              height: 130,
              child: Card(
                elevation: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage('assets/images/avator.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Safwan Idrees',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Karachi , Pakistan',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.grey[800]),
                          ),
                        ),
                        Container(
                          child: Text(
                            'xxxxxxxxxxxxxxxxxxxxx',
                            style: TextStyle(
                                fontFamily: 'Aleo',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.grey[500]),
                          ),
                        ),
                        Container(
                          child: Text(
                            '03-2xxx xxxx',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
