import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathonabren/pages/driver_home_amharic.dart';
import 'package:hackathonabren/pages/rider_home.dart';
import 'package:hackathonabren/pages/rider_home_amharic.dart';

import 'driver_home.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrange[600],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
              Navigator.pushNamed(context, '/travel_history');
            },

          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language Preferences'),
            onTap: () async {},
          ),
          ListTile(
            title:
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text('English'),
                ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DriverHome()));
//              Navigator.pushReplacement(
//                  context, MaterialPageRoute(builder: (context) => RiderHome()));
            },
          ),
          ListTile(
            title:
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Text('Amharic'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => DriverHomeAmharic()));
//              Navigator.pushReplacement(
//                  context, MaterialPageRoute(builder: (context) => RiderHomeAmharic()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
