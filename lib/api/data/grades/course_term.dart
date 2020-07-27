import 'package:msu_grades/api/data/grades/course.dart';
import 'package:msu_grades/api/data/grades/instructor.dart';

class CourseTerm {
  Course course;
  List<Instructor> instructors;
  Map<double, int> gradeCounts;
}
