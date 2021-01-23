import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'drawer_widget.dart';
import 'horizontal_timeline_widget.dart';

class DriverHomeAmharic extends StatefulWidget {
  @override
  _DriverHomeAmharicState createState() => _DriverHomeAmharicState();
}

class _DriverHomeAmharicState extends State<DriverHomeAmharic> {
  int listLength = 10;
  Widget makeCard() {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/driver_requests');
        },
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                  child: HorizontalTimelineWidget(pathPoints: [
                    "Yerer",
                    "Mebrat Hail",
                    "Roba",
                    "Bole Homes",
                    "Bole"
                  ]),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Yerer ---> Bole",
                style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "የመጨረሻ የተወሰደው: ጥር 15፣ 2013",
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'የጉዞ መስመሮች',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
      drawer: DrawerWidget(),
      body: SlidingUpPanel(
          maxHeight: screen_height * (1 / 3),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "ከዚህ በፊት የሄዱበትን አንድ የጉዞ መስመር ይምረጡ",
                    style: TextStyle(color: Colors.black54, fontSize: 17),
                  ),
                ),
                Container(
                  height: screen_height * 9 / 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              makeCard(),
                              SizedBox(
                                height: 10,
                              ),
//                              ListTile(
//                                title: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      "Yerer  -  Bole",
//                                      style: TextStyle(
//                                          fontSize: 17,
//                                          color: Theme.of(context).primaryColor,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                    SizedBox(
//                                      height: 5,
//                                    ),
//                                    HorizontalTimelineWidget(pathPoints: [
//                                      "Yerer",
//                                      "Mebrat Hail",
//                                      "Roba",
//                                      "Bole Homes",
//                                      "Bole"
//                                    ]),
//                                  ],
//                                ),
//                                trailing: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.arrow_forward_ios,
//                                      color: Colors.black26,
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Divider(),
                              Container(
                                  height: screen_height *
                                      (1 / 2))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
          panel: Padding(
            padding:
            const EdgeInsets.only(top: 7, bottom: 10, left: 15, right: 15),
            child: Column(
              children: [
                Center(
                  child: Icon(Icons.drag_handle),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "ከላይ ያሉትን የጉዞ መስመሮች ካልሄዱ?",
                          style:
                          TextStyle(fontSize: 17, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: OutlineButton(
                            color: Colors.white,
                            borderSide:
                            BorderSide(width: 2, color: Colors.black12),
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(height: 40, child: VerticalDivider()),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Text(
                                    "አዲስ የጉዞ መስመር ይፍጠሩ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Theme.of(context).accentColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "ወይም የሚወስዶ ሰው ማግኘት ይፈልጋሉ?",
                          style:
                          TextStyle(fontSize: 17, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(10),
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.directions_car,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                    height: 40,
                                    child:
                                    VerticalDivider(color: Colors.white)),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Text(
                                    "የሚወስዶ ሰው ይፈልጉ",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
