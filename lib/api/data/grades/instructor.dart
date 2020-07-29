import 'package:flutter/material.dart';
import 'package:msu_grades/api/data/grades/course_term.dart';
import 'package:msu_grades/api/data/grades/msu_object.dart';
import 'package:msu_grades/util/StringUtil.dart';

class Instructor extends MsuObject {
  String _name;

  set name(value) {
    _name = value
        .split(',')
        .reversed
        .map(
            (e) => e.split(RegExp(r"\s+")).map(StringUtil.capitalize).join(' '))
        .join('');
  }

  String get name {
    return _name;
  }

  List<CourseTerm> courses;

  Instructor(String name, List<CourseTerm> courseTerms) {
    this.name = name;
    this.courses = courseTerms;
  }

  @override
  displayDuringLookup() {
    return FlatButton(child: Text(name)); // TODO: add onPressed functionality
  }
}
