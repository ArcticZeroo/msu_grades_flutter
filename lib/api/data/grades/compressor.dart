import 'package:msu_grades/api/data/grades/course.dart';
import 'package:msu_grades/api/data/grades/course_term.dart';
import 'package:msu_grades/api/data/grades/instructor.dart';

/// The dataset we receive has a lot of data that is pretty unnecessary,
/// so it makes more sense to strip those columns out to save on device
/// storage (which will also help with read speed later on)
abstract class DatasetCompressor {
  static List<List<dynamic>> compressDataset(List<List<dynamic>> csv) {
    List<dynamic> instructors;
    List<dynamic> courses;
    List<dynamic> courseTerms;

    Map<String, Instructor> instructorMap;
    Map<String, Course> courseMap;
    Map<String, CourseTerm> courseTermMap;

    for (int lineIndex = 1; lineIndex < csv.length; lineIndex++){ // The first line is a header, so skip it
      List<dynamic> line = csv[lineIndex];

      var term = line[0];
      var subjectCode = line[2];
      var courseCode = line[3];
      var courseTitle = line[4];
      List<dynamic> instructors = line[5].split("|");
    }


    return [instructors, courses, courseTerms];
  }

  static String reformatInstructorName(String rawName){
    return "";
  }

  static Instructor createInstructor(String name){
    return Instructor(name, []);
  }

  static void updateInstructorData(Instructor instructor, CourseTerm term){
    instructor.courses.add(term);
  }

  static Course createCourse(String information){

    return Course();
  }

  static CourseTerm createCourseTerm(String information){

    return CourseTerm();
  }
}
