import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackathonabren/pages/driver_home.dart';
import 'package:hackathonabren/pages/rider_home.dart';

import '../main.dart';

class RegisterPreference extends StatefulWidget {
  final String role;
  const RegisterPreference({Key key, this.role}): super(key : key);
  @override
  _RegisterPreferenceState createState() => _RegisterPreferenceState();
}

class _RegisterPreferenceState extends State<RegisterPreference> {
  TextEditingController _codeController = new TextEditingController();

  Map<String, List> preferenceValues = {
    //TODO: Better implementation
    "18 - 25": [false, false, false],
    "25 - 50": [false, false, false],
    "> 50 ": [false, false, false],
    "People with Disabilities": [false, false, false]
  };
  Widget preferenceCard(String title) {
    return Card(
      child: AnimatedContainer(
        height: preferenceValues[title][0] ? 120 : 70,
        duration: Duration(milliseconds: 300),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if(title != "People with Disabilities")
                    Text(
                      "Age Group",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    Text(title),
                  ],
                ),
                onChanged: (bool value) {
                  setState(() {
                    preferenceValues[title][0] = value;
                    preferenceValues[title][1] = value;
                    preferenceValues[title][2] = value;
                  });
                },
                value: preferenceValues[title][0],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Switch(
                    onChanged: (bool value) {
                      setState(() {
                        preferenceValues[title][1] = value;
                      });
                    },
                    value: preferenceValues[title][1],
                    activeColor: Colors.pinkAccent,
                  ),
                  Text("Female"),
                  Switch(
                    onChanged: (bool value) {
                      setState(() {
                        preferenceValues[title][2] = value;
                      });
                    },
                    value: preferenceValues[title][2],
                    activeColor: Colors.blueAccent,
                  ),
                  Text("Male")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
            'Register',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Preferences",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Select the types of people you want to give rides to",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 20),
              preferenceCard("18 - 25"),
              preferenceCard("25 - 50"),
              preferenceCard("> 50 "),
              preferenceCard("People with Disabilities"),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      "You can change your preferences at anytime",
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text("Back", overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        if(widget.role == "DRIVER"){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => DriverHome()));
                        }else{
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => RiderHome()));
                        }

                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child:
                            Text("Finish", overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
