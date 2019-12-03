import 'ReadText.dart';
import 'package:flutter/material.dart';
import 'SpeakText.dart';

class LocationsPage extends StatefulWidget {
  final PageController controller;

  LocationsPage({Key key, @required this.controller}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState(controller);
}

class _LocationsPageState extends State<LocationsPage> {
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final PageController controller;
  var roomNames = ["English Class", "History Class"];
  var roomLocations = ["ECSS Floor 2, Room 2.12", "ECSS Floor 1, Room 1.18"];
  var roomImages = [
    'assets/images/classroom1.jpg',
    'assets/images/classroom4.jpg'
  ];
  var readText = ReadText();
  var speakText = SpeakText();

  var locationsText = "You have 2 available locations." +
      "The first location is English Class on Floor 2 in Room 2.12." +
      "The second location is History Class on Floor 1 in Room 1.18. Where would you like to go?";

  _LocationsPageState(this.controller);

  @override
  initState() {
    super.initState();
    readText.initTts();
    speakText.initSpeechRecognizer();
    speakText.speechRecognition.setRecognitionCompleteHandler(
      () => this.printFinalText(),
    );
  }

  void printFinalText() {
    speakText.setListening(false);
    var userQuery = speakText.resultText;
    if ((userQuery.contains("read") || userQuery.contains("list")) &&
        userQuery.contains("location")) {
      print("Reading all locations");
      readText.speak(locationsText);
    } else if (userQuery.contains("go") ||
        userQuery.contains("to") ||
        userQuery.contains("direction")) {
      print("Going to location");
      if (userQuery.contains("english")) {
        readText.speak("Loading directions for English Class");
        // Navigate to map
      } else if (userQuery.contains("history")) {
        // navigate to map
        readText.speak("Loading directions for English Class");
      } else {
        readText.speak(
            "Sorry, I could not understand. Please say something like go to english class or go to history class.");
      }
    } else {
      readText.speak(
          "Sorry I could not understand your command. Please say something like read all locations or go to english class");
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    readText.flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return new Scaffold(
        backgroundColor: Colors.cyanAccent[700],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                          onTap: () {
                            controller.animateToPage(2,
                                duration: _kDuration, curve: _kCurve);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                  height: 160,
                                  margin: const EdgeInsets.all(8.0),
                                  color: Colors.white,
                                  child: Column(children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(roomImages[index]),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(roomNames[index],
                                            style: TextStyle(fontSize: 26)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "Located in " + roomLocations[index],
                                        ),
                                      ),
                                    ),
                                  ]))));
                    }),
              ),
            ),
            Container(
              width: double.infinity,
              // color: Colors.blue,
              height: _size.height * 0.25,
              // Take 25% width of the screen height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: _size.width * 0.5,
                    height: double.infinity,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text('Speech to text'),
                      onPressed: () {
                        readText.stop();
                        print("Speech to text");
                        speakText.speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: _size.width * 0.5,
                    height: double.infinity,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text('Text to speech'),
                      onPressed: () {
                        print("Text to speech");
                        readText.speak(locationsText);
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
