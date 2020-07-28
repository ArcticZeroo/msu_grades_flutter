import 'package:flutter/material.dart';
import 'package:msu_grades/api/data/grades/course_term.dart';
import 'package:msu_grades/api/data/grades/msu_object.dart';
import 'package:msu_grades/util/StringUtil.dart';

class Instructor extends MsuObject{
  String rawName; // CHENEY,LAURA M
  String get name {
    return rawName
        .split(',')
        .reversed
        .map((e) => StringUtil.capitalize(e))
        .join('');
  }

  List<CourseTerm> courses;

  @override
  displayDuringLookup(){
    return FlatButton(child: Text(name)); // TODO: add onPressed functionality
  }
}
