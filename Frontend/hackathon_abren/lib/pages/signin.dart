import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathonabren/main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0, bottom: 80.0),
                    child: Text(
                      "Abren",
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 1,
                        child: TextFormField(
                          initialValue: "+251",
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Material(
                        elevation: 2,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            hintText: "Enter Phone Number",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 15),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  padding: EdgeInsets.all(15),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Send Authorization Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "New to Abren?",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OutlineButton(
                  color: Colors.white,
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .accentColor), // TODO: On pressed color
                  focusColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
