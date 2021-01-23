import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'horizontal_timeline_widget.dart';
import 'map_widget.dart';

class RiderAccepted extends StatefulWidget {
  @override
  _RiderAcceptedState createState() => _RiderAcceptedState();
}

class _RiderAcceptedState extends State<RiderAccepted> {
  MapWidget mapWidget;
  final GlobalKey<MapWidgetState> mapKey = GlobalKey<MapWidgetState>();
  @override
  void initState() {
    mapWidget = MapWidget(key: mapKey, images: [
      "assets/symbols/car.png"
    ]);
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
  Widget requestContainer = Container();
  String status = "ACCEPTED";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Timer(Duration(seconds: 2), () {
      if (!called1) {
        print("CALLED");
        setState(() {
          called1 = true;
          mapKey.currentState.addSymbol(
              LatLng(9.002915, 38.817478), "assets/symbols/marker.png");
        });
      }
    });

    Timer(Duration(seconds: 20), () {
      if (!called2) {
        print("CALLED");
        setState(() {
          called2 = true;
          status = "INRIDE";
        });
      }
    });
    return Stack(
      children: [
        mapWidget,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (status == "INRIDE")
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
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.done_rounded,
                                    color: Theme.of(context).primaryColor),
                                SizedBox(height: 5),
                                Text(
                                  "Ride has Started",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            )),
                      SizedBox(height: 10),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_pin, color: Theme.of(context).primaryColor),
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
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
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
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
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
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "OTP:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "1234",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
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
                                            "Car Type:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Vitz",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
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
                                            "Car Color:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Golden",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
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
                                            "License Plate Number:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "XXXXX",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Theme.of(context).primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
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
                                pathPoints[0] + " ---> " + pathPoints[pathPoints.length - 1],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              HorizontalTimelineWidget(pathPoints: pathPoints),
                            ],
                          )),
                      SizedBox(height: 5)
                    ],
                  )
            ],
          ),
        )
      ],
    );
  }
}
