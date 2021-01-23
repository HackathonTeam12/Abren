import 'package:flutter/material.dart';
import 'package:hackathonabren/pages/rider_accepted.dart';
import 'package:hackathonabren/pages/rider_nearby.dart';
import 'package:hackathonabren/pages/rider_requests.dart';

import 'drawer_widget.dart';

class RiderRequestsAndAccepted extends StatefulWidget {
  RiderRequestsAndAccepted({Key key}) : super(key: key);

  @override
  _RiderRequestsAndAcceptedState createState() =>
      _RiderRequestsAndAcceptedState();
}

class _RiderRequestsAndAcceptedState extends State<RiderRequestsAndAccepted> {
  int _currentIndex = 0;
  final List<String> _titles = [
    "Nearby Rides",
    "Sent Requests",
    "Accepted"
  ];
  List<Widget> buildChildren(){
    return  [
      RiderNearby(),
      RiderRequests(),
      RiderAccepted()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to stop looking for a ride?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: Theme.of(context).accentColor),),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes', style: TextStyle(color: Theme.of(context).accentColor),),
              ),
            ],
          ),
        )) ??
            false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                _titles[_currentIndex],
                style: TextStyle(color: Theme.of(context).primaryColor),
              )),
          drawer: DrawerWidget(),
          body: IndexedStack(
            index: _currentIndex,
            children: buildChildren(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            }, // new
            currentIndex: _currentIndex, // new
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.help_outline),
                title: Text('Nearby'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help_outline),
                title: Text('Requests'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                title: Text('Accepted'),
              ),
            ],
          ),
      ),
    );
  }
}
