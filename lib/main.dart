import 'package:flutter/material.dart';
import 'package:msu_grades/app/views/home.dart';
import 'package:msu_grades/app/views/loading_popover.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSU Grades',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        accentColor: Colors.greenAccent,
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      home: LoadingPopover(HomeView()),
    );
  }
}
