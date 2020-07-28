import 'dart:async';

import 'package:flutter/foundation.dart';

typedef FileDownloadedCallback = void Function(List<int> bytes);

class FileProgressNotifier extends ValueNotifier<double> {
  final Stream<List<int>> stream;
  final int streamSize;
  final List<int> _receivedBytes;
  final FileDownloadedCallback onDownloaded;

  FileProgressNotifier(
      {@required this.stream,
      @required this.streamSize,
      @required this.onDownloaded})
      : _receivedBytes = [],
        super(0.0);

  Future<void> download() async {
    await for (var data in stream) {
      _receivedBytes.addAll(data);
      value = _receivedBytes.length / streamSize;
    }
    onDownloaded(_receivedBytes);
    _receivedBytes.clear();
  }
}
