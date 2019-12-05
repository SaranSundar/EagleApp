import 'camera_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'contact_page.dart';
import 'locations_page.dart';
import 'maps_page.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

final controller = PageController(initialPage: 1);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AccelerometerEvent event; // Event returned from accelerometer stream
  Timer timer;
  StreamSubscription accel;
  double prevZ = 10;
  bool alerted = false;

  @override
  void initState() {
    super.initState();
    monitorAcceleration();
  }

  void monitorAcceleration() {
    // If the accelerometer subscription hasn't been created, go ahead and create it
    if (accel == null) {
      accel = accelerometerEvents.listen((AccelerometerEvent eve) {
        setState(() {
          event = eve;
          // If it detects a rapid change in height, shows an alert message.
          if((prevZ - event.z).abs() > 5 && !alerted){
            alerted = true;
            showAlert(context);
          }
          //print("PrevZ: " + prevZ.toString() + "CurZ: " + (event.z).toString());
          prevZ = event.z;
        });
      });
    } else {
      // If it has already been created just resume it
      accel.resume();
    }
  }

  void showAlert(BuildContext context) {
    Widget resumeButton = FlatButton(
      child: Text("Resume"),
      onPressed: () {
        alerted = false;
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("ALERT"),
          content: Text("I've fallen down. Help me!"),
          actions: [
            resumeButton
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          FontAwesomeIcons.featherAlt,
          color: Colors.white,
        ),
        title: Text(
          "Eagle",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        children: [
          ContactPage(controller: controller),
          LocationsPage(controller: controller),
          MapsPage(),
          CameraApp(),
        ],
      ),
    );
  }
}
