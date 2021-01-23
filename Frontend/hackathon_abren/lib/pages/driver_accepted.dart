import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'map_widget.dart';

class DriverAccepted extends StatefulWidget {
  @override
  _DriverAcceptedState createState() => _DriverAcceptedState();
}

class _DriverAcceptedState extends State<DriverAccepted> {
  final GlobalKey<MapWidgetState> mapKey = GlobalKey<MapWidgetState>();
  MapWidget mapWidget;
  TextEditingController _codeController = TextEditingController();
  @override
  void initState() {
    mapWidget = MapWidget(key: mapKey, images: ["assets/symbols/marker.png"]);
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

  String status = "ACCEPTED";
  String inputText = "Enter OTP";
  String buttonText = "Validate";
  bool called = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    Timer(Duration(seconds: 1), () {
      if (!called) {
        print("CALLED");
        setState(() {
          called = true;
          mapKey.currentState.addSymbol(LatLng(9.002915, 38.817478),
              "assets/symbols/marker.png");
        });
      }
    });
    return Stack(
      children: [
        mapWidget,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Chip(
                        elevation: 2,
                        backgroundColor: Colors.white,
                        label: Row(
                          children: [
                            Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                "Accepted",
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
                      child: Chip(
                        elevation: 2,
                        backgroundColor: Colors.white,
                        label: Row(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                "In Ride",
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
                  ],
                ),
                Column(
                  children: [
                      Container(
                        width: screenWidth,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 2,
                                child: TextFormField(
                                  enabled: status == "ACCEPTED" ? true : false,
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    hintText: inputText,
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: status == "ACCEPTED" ? Colors.grey[500] : Theme.of(context).primaryColor),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 7),
                            RaisedButton(
                              onPressed: () {
                                _codeController.text = "";
                                setState(() {
                                  status = "INRIDE";
                                  inputText = "Ride started at: " + TimeOfDay.now().hourOfPeriod.toString() + ":" + TimeOfDay.now().minute.toString() + " PM";
                                  buttonText = "Rate";
                                });
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 10),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                buttonText,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 5),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth - 80,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person_pin,
                                          color: Theme.of(context).primaryColor),
                                      SizedBox(width: 10),
                                      Text(
                                        "Amen Sime",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gender:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Female",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Age Group:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "18 - 25",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Rating:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Container(
                                                child: Wrap(
                                                  children: buildStars(4),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Destination:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Roba Bakery",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
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
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {},
                            color: Theme.of(context).primaryColor,
                            child:
                            Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 3,
                          child: RaisedButton(
                              onPressed: null,
                              disabledColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      status == "ACCEPTED"
                                          ? Icons.timer
                                          : Icons.done,
                                      color: Theme.of(context).primaryColor),
                                  SizedBox(width: 5),
                                  Text(
                                      status == "ACCEPTED"
                                          ? "Waiting"
                                          : "In Ride",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor))
                                ],
                              )),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {},
                            color: Theme.of(context).primaryColor,
                            child: Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
