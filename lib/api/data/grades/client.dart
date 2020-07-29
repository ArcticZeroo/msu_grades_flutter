import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:msu_grades/api/data/grades/compressor.dart';
import 'package:msu_grades/api/data/grades/dataset.dart';
import 'package:msu_grades/api/data/grades/parser.dart';
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
  GradeDataset get dataset => _dataset;

  bool get isDatasetLoaded {
    return _dataset != null;
  }

  void _onCsvLoaded(List<List<dynamic>> csv) {
    _dataset = DatasetParser.parse(csv);
  }

  List<List<dynamic>> _fileContentsToCsv(String fileContents) {
    return const CsvToListConverter().convert(fileContents);
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, _fileName);
  }

  Future<bool> isSavedOnDevice() async {
    return FileUtil.exists(await getFilePath());
  }

  Future<void> downloadFromServer(DownloadProgressCallback onProgress) async {
    DownloadFileWithProgress downloader =
        DownloadFileWithProgress(downloadUri: Uri.parse(_downloadUrl));

    VoidCallback progressListener = () {
      onProgress(downloader.progress.value);
    };

    downloader.progress.addListener(progressListener);
    final bytes = await downloader.download();
    downloader.progress.removeListener(progressListener);

    final fileContents = utf8.decode(bytes);
    final csv = _fileContentsToCsv(fileContents);
    final compressedCsv = DatasetCompressor.compressDataset(csv);
    _onCsvLoaded(compressedCsv);

    final fileSavePath = await getFilePath();
    final file = File(fileSavePath);
    await file.writeAsString(const ListToCsvConverter().convert(compressedCsv));
  }

  Future<void> readFromFile() async {
    final file = File(await getFilePath());
    final fileContents = await file.readAsString();
    _onCsvLoaded(_fileContentsToCsv(fileContents));
  }
}
