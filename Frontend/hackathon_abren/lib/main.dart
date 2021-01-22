import 'package:flutter/material.dart';
import 'package:hackathonabren/pages/register_first.dart';
import 'package:hackathonabren/pages/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abren',
      theme: ThemeData(
          primaryColor: Colors.deepOrange[700],
          accentColor: Colors.amber[700],
          fontFamily: 'PTSans'
      ),
      routes: {
        '/signup' : (context) => RegisterFirst(),
      },
      home: SignIn(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abren"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
