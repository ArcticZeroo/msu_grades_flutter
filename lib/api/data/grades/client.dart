import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:msu_grades/api/data/grades/dataset.dart';
import 'package:msu_grades/api/progress/download_file_with_progress.dart';
import 'package:msu_grades/util/FileUtil.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

typedef DownloadProgressCallback = void Function(double progress);

class GradeDatasetClient {
  static const String _downloadUrl = 'https://msugrades.com/excel/master.csv';
  static const String _fileName = 'dataset.csv';
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

  void _onCsvLoaded(List<List<dynamic>> csv) {
    _dataset = _parseDatasetFile(csv);
  }

  List<List<dynamic>> _fileContentsToCsv(String fileContents) {
    return const CsvToListConverter().convert(fileContents);
  }

  Future<String> getFilePath() async {
    var directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, _fileName);
  }

  Future<bool> isSavedOnDevice() async {
    return FileUtil.exists(await getFilePath());
  }

  Future<void> downloadFromServer(DownloadProgressCallback onProgress) async {
    DownloadFileWithProgress downloader = DownloadFileWithProgress(
        downloadUri: Uri.parse(_downloadUrl), savePath: await getFilePath());

    VoidCallback progressListener = () {
      onProgress(downloader.progress.value);
    };

    downloader.progress.addListener(progressListener);
    var bytes = await downloader.download();
    downloader.progress.removeListener(progressListener);

    var fileContents = utf8.decode(bytes);
    var csv = _fileContentsToCsv(fileContents);
    _onCsvLoaded(csv);
  }

  Future<void> readFromFile() async {
    File file = File(await getFilePath());
    var fileContents = await file.readAsString();
    _onCsvLoaded(_fileContentsToCsv(fileContents));
  }
}
