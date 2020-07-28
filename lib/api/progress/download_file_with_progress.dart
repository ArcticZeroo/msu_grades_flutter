import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:synchronized/synchronized.dart';

class DownloadFileWithProgress {
  final ValueNotifier<double> progress;
  final Uri downloadUri;
  final String savePath;
  final Lock _lock = new Lock();
  int _totalByteCount;
  List<int> _receivedBytes = [];

  DownloadFileWithProgress(
      {@required this.downloadUri, @required this.savePath})
      : progress = new ValueNotifier(0.0);

  Future<List<int>> download() async {
    return await _lock.synchronized(() async {
      _totalByteCount = 0;
      _receivedBytes.clear();

      var response = await http.Client().send(http.Request('GET', downloadUri));
      _totalByteCount = response.contentLength;

      await for (var bytes in response.stream) {
        _receivedBytes.addAll(bytes);
        progress.value = _receivedBytes.length / _totalByteCount;
      }

      final file = File(savePath);
      await file.writeAsBytes(_receivedBytes);
      return _receivedBytes;
    });
  }
}
