import 'package:flutter/material.dart';
import 'package:msu_grades/api/data/grades/course_term.dart';
import 'package:msu_grades/api/data/grades/msu_object.dart';

class Course extends MsuObject{
  /// Title of the course i.e. Introduction to python
  String title;

  /// Subject of course i.e. CSE
  String subjectCode;

  /// Course code in department i.e. 231
  String courseCode;

  String description;
  List<CourseTerm> terms;

  @override
  displayDuringLookup(){
    return FlatButton(child: Text("$subjectCode $courseCode $title"));
  }
}
