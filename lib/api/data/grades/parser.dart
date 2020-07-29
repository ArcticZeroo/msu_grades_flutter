import 'package:msu_grades/api/data/grades/dataset.dart';

abstract class DatasetParser {
  /// Parses a dataset after it has been compressed by a [DatasetCompressor], or
  /// after it has been read from a file (in which case it had been compressed
  /// before the file was written)
  static GradeDataset parse(List<List<dynamic>> csv) {
    return null;
  }
}
