import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'horizontal_timeline_widget.dart';
import 'map_widget.dart';

class RiderNearby extends StatefulWidget {
  RiderNearby({Key key}) : super(key: key);

  @override
  _RiderNearbyState createState() => _RiderNearbyState();
}

class _RiderNearbyState extends State<RiderNearby> {
  MapWidget mapWidget;
  final GlobalKey<MapWidgetState> mapKey = GlobalKey<MapWidgetState>();

  @override
  void initState() {
    mapWidget = MapWidget(key: mapKey, images: ["assets/symbols/car.png"]);
    super.initState();
  }

  List<Widget> buildStars(double rating) {
    List<Widget> stars = [];
    int full = rating.toInt();
    for (var i = 0; i < full; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.orangeAccent,
      ));
      if (stars.length == 5) {
        return stars;
      }
    }
    if (rating - full != 0) {
      stars.add(Icon(
        Icons.star_half,
        color: Colors.orangeAccent,
      ));
    }
    int length = stars.length;
    for (var i = 0; i < (5 - length); i++) {
      stars.add(Icon(
        Icons.star_border,
        color: Colors.orangeAccent,
      ));
    }
    return stars;
  }

  List<String> pathPoints = [
    "Yerer",
    "Mebrat Hail",
    "Roba",
    "Bole Homes",
    "Bole"
  ];

  bool called1 = false;
  bool called2 = false;
  Widget requestContainer = Chip(
    backgroundColor: Colors.white,
    label: Wrap(
      children: [
        Text(
          "0",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange[700]),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Nearby",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Timer(Duration(seconds: 5), () {
      if (!called1) {
        print("CALLED");
        setState(() {
          called1 = true;
          mapKey.currentState.addSymbol(
              LatLng(9.002915, 38.817478), "assets/symbols/marker.png");

          requestContainer = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                backgroundColor: Colors.white,
                label: Wrap(
                  children: [
                    Text(
                      "1",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Nearby",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Container(
                  width: (screenWidth - 80),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_pin,
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: 10),
                          Text(
                            "Salem Getachew",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender:",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Female",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Age Group:",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "18 - 25",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating:",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Container(
                                    child: Wrap(
                                      children: buildStars(4.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pathPoints[0] +
                            " ---> " +
                            pathPoints[pathPoints.length - 1],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      HorizontalTimelineWidget(pathPoints: pathPoints),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: RaisedButton(
                        onPressed: () {},
                        color: Theme.of(context).primaryColor,
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white)),
                  )
                ],
              )
            ],
          );
        });
      }
    });

    Timer(Duration(seconds: 10), () {
      if (!called2) {
        print("CALLED");
        setState(() {
          called2 = true;
          mapKey.currentState.removeAll();

          requestContainer = Chip(
            backgroundColor: Colors.white,
            label: Wrap(
              children: [
                Text(
                  "0",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Nearby",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        });
      }
    });

    return Stack(
      children: [
        mapWidget,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: Row(
                        children: [
                          Icon(Icons.wifi),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              "Finding Rides",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.stop_circle_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Flexible(
                            child: Text(
                              "Stop",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              requestContainer
            ],
          ),
        )
      ],
    );
  }
}
