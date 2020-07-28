import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:msu_grades/api/data/grades/dataset.dart';
import 'package:msu_grades/api/progress/download_file_with_progress.dart';
import 'package:msu_grades/util/FileUtil.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class GradeDatasetClient {
  static const String _downloadUrl = "";
  static const String _fileName = "dataset.csv";
  static GradeDatasetClient _instance;

  static GradeDatasetClient get instance {
    if (_instance == null) {
      _instance = new GradeDatasetClient();
    }
    return _instance;
  }

  GradeDataset _dataset;

  bool get isDatasetLoaded {
    return _dataset != null;
  }

  GradeDataset _parseDatasetFile(List<List<dynamic>> csv) {
    return null;
  }

  Future<String> getFilePath() async {
    var directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, _fileName);
  }

  Future<bool> isSavedOnDevice() async {
    return FileUtil.exists(await getFilePath());
  }

  Future<DownloadFileWithProgress> downloadFromServer() async {
    DownloadFileWithProgress downloader = DownloadFileWithProgress(
        downloadUri: Uri.parse(_downloadUrl), savePath: await getFilePath());

    downloader.download().then((bytes) {
      var fileContents = CsvToListConverter().convert(utf8.decode(bytes));
    });

    return downloader;
  }

  Future<GradeDataset> readFromFile() async {
    File file = File(await getFilePath());
    await file.readAsString();
  }
}
