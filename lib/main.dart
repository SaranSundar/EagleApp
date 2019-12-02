import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eagle/loc_with_speech.dart';
import 'package:eagle/speak_text.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'contact_page.dart';
import 'locations_page.dart';
import 'maps_page.dart';

final controller = PageController(initialPage: 1);
List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
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
          CameraApp()
        ],
      ),
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  CameraAppState createState() => CameraAppState();
}

class CameraAppState extends State<CameraApp> {
  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }
}