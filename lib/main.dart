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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: LoadingPopover(HomeView()),
    );
  }
}
