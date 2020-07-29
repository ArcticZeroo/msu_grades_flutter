import 'package:fuzzy/fuzzy.dart';
import 'package:msu_grades/api/data/grades/client.dart';
import 'package:msu_grades/api/data/grades/course.dart';
import 'package:msu_grades/api/data/grades/instructor.dart';

class DatasetSearch {
  static DatasetSearch _instance;

  static DatasetSearch get instance {
    if (_instance == null) {
      _instance = DatasetSearch();
    }
    return _instance;
  }

  Fuzzy _courseFuzzySearch;
  Fuzzy _instructorFuzzySearch;
  final Map<String, Course> _courseIdToCourse = {};
  final Map<String, Instructor> _instructorNameToInstructor = {};

  Fuzzy get courseFuzzySearch {
    _assertDatasetIsLoaded();
    if (_courseFuzzySearch == null) {
      _courseFuzzySearch = Fuzzy(buildCourseDictionary());
    }
    return _courseFuzzySearch;
  }

  Fuzzy get instructorFuzzySearch {
    _assertDatasetIsLoaded();
    if (_instructorFuzzySearch == null) {
      _instructorFuzzySearch = Fuzzy(buildInstructorDictionary());
    }
    return _instructorFuzzySearch;
  }

  void _assertDatasetIsLoaded() {
    assert(GradeDatasetClient.instance.isDatasetLoaded);
  }

  List<String> buildCourseDictionary() {
    if (_courseIdToCourse.isNotEmpty) {
      return _courseIdToCourse.keys.toList();
    }

    return GradeDatasetClient.instance.dataset.courses.map((course) {
      final courseId = course.id;
      _courseIdToCourse[courseId] = course;
      return courseId;
    }).toList();
  }

  List<String> buildInstructorDictionary() {
    if (_instructorNameToInstructor.isNotEmpty) {
      return _instructorNameToInstructor.keys.toList();
    }

    return GradeDatasetClient.instance.dataset.instructors.map((instructor) {
      final instructorName = instructor.name;
      _instructorNameToInstructor[instructorName] = instructor;
      return instructor.name;
    }).toList();
  }

  List<T> _search<T>(
      String query, Fuzzy fuzzy, Map<String, T> searchTermToResult) {
    final results = fuzzy.search(query) ?? [];
    final out = <T>[];
    for (var result in results) {
      final searchTerm = result.item;
      out.add(searchTermToResult[searchTerm]);
    }
    return out;
  }

  List<Course> searchForCourses(String query) {
    return _search(query, _courseFuzzySearch, _courseIdToCourse);
  }

  List<Instructor> searchForInstructors(String query) {
    return _search(query, _instructorFuzzySearch, _instructorNameToInstructor);
  }
}
