import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final List<String> contacts = [
    'Katie','Ken','Mark','Nikhil','Ricardo','Saran'
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyanAccent[700],
      body: new Container(
        child: new ListView.builder(
          reverse: false,
          itemBuilder: (_,int index)=>EachList(this.contacts[index]),
          itemCount: this.contacts.length,
        ),
      ),
    );
  }
}

class EachList extends StatelessWidget{
  final String name;
  EachList(this.name);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        launch("tel://2142188976");
      },
      child: new Card(
        child: new Container(
          padding: EdgeInsets.all(8.0),
          child: new Row(
            children: <Widget>[
              new CircleAvatar(child: new Text(name[0]),),
              new Padding(padding: EdgeInsets.only(right: 10.0)),
              new Text(name,style: TextStyle(fontSize: 20.0),)
            ],
          ),
        ),
      ),
    );
  }
}