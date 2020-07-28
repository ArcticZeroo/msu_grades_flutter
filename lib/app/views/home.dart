import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("MSU Grades")),
      body: Center(
        child: FlatButton(
          textColor: Colors.green, // Theme.color.of(context).primaryTextTheme.bodyText2,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(6)),
                child: Text("Search MSU Grades", textScaleFactor: 4.0,))),
      ),
    );
  }
}
