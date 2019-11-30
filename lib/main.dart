import 'package:eagle/loc_with_speech.dart';
import 'package:eagle/speak_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'contact_page.dart';
import 'locations_page.dart';
import 'maps_page.dart';
import 'camera_page.dart';

final controller = PageController(initialPage: 1);

void main() => runApp(MyApp());

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
          ContactPage(),
          SpeakText(),
          LocWithSpeech(),
          LocationsPage(controller: controller),
          MapsPage(),
          CameraPage()
        ],
      ),
    );
  }
}
