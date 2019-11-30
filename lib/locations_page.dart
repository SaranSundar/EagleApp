import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget{
  final PageController controller;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  var roomNames = ["Classroom A", "Classroom B", "Classroom C", "Classroom D"];
  var roomLocations = ["ECSS Floor 2, Room 2.12", "ECSN Floor 3, Room 3.41", "CB Floor 1, Room 1.04", "ECSW Floor 1, Room 1.18"];
  var roomImages = ['assets/images/classroom1.jpg', 'assets/images/classroom2.jpg', 'assets/images/classroom3.jpg', 'assets/images/classroom4.jpg'];

  LocationsPage({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyanAccent[700],
      body: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                onTap: () {
                  controller.animateToPage(2, duration: _kDuration, curve: _kCurve);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 160,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
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
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                roomNames[index],
                                style: TextStyle(
                                    fontSize: 26
                                )
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Located in " + roomLocations[index],
                            ),
                          ),
                        ),
                      ]
                    )
                  )
                )
            );
          }
      )
    );
  }
}