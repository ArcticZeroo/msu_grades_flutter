import 'package:flutter/widgets.dart';
import 'package:msu_grades/api/data/grades/client.dart';
import 'package:msu_grades/api/data/grades/dataset.dart';
import 'package:msu_grades/api/progress/download_file_with_progress.dart';

class LoadingPopover extends StatefulWidget {
  final Widget bottomLayer;

  LoadingPopover(this.bottomLayer);

  @override
  State<StatefulWidget> createState() => _LoadingPopoverState();
}

class _LoadingPopoverState extends State<LoadingPopover> {
  Future<bool> _isFileOnDevice;
  Future<GradeDataset> _datasetLoading;
  DownloadFileWithProgress _downloader;

  @override
  Widget build(BuildContext context) {
    if (GradeDatasetClient.instance.isDatasetLoaded) {
      return widget.bottomLayer;
    }
  }
}
