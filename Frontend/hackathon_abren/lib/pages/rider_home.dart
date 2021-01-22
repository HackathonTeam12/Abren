import 'package:flutter/material.dart';

import 'drawer_widget.dart';

class RiderHome extends StatefulWidget {
  @override
  _RiderHomeState createState() => _RiderHomeState();
}

class _RiderHomeState extends State<RiderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Where do you want to go?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Material(
                    elevation: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on, color: Colors.grey[500],),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        hintText: "Select Destination",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).accentColor)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Recent Destinations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[800]
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: MediaQuery.of(context).size.height * (2 / 5),
                  child: Scrollbar(
                    child: ListView(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/rider_requests');
                          },
                          title: Text(
                            "KADISCO General Hospital",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor
                            ),
                          ),
                          subtitle: Text(
                              "Last Traveled on June 2, 2020"
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black26,),
                        ),
                        Divider(),
                      ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
