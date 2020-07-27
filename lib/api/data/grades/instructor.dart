import 'package:msu_grades/api/data/grades/course_term.dart';
import 'package:msu_grades/util/StringUtil.dart';

class Instructor {
  String rawName; // CHENEY,LAURA M
  String get name {
    return rawName
        .split(',')
        .reversed
        .map((e) => StringUtil.capitalize(e))
        .join('');
  }

  List<CourseTerm> courses;
}
