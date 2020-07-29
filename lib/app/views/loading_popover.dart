import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msu_grades/api/data/grades/client.dart';
import 'package:msu_grades/app/views/loading.dart';

class LoadingPopover extends StatefulWidget {
  final Widget bottomLayer;

  LoadingPopover(this.bottomLayer);

  @override
  State<StatefulWidget> createState() => _LoadingPopoverState();
}

class _LoadingPopoverState extends State<LoadingPopover> {
  LoadingStatus _loadingStatus = LoadingStatus.fetchingMetadata;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    load().catchError((error) {
      print(error);
      setState(() {
        _loadingStatus = LoadingStatus.failed;
      });
    });
  }

  Future<void> load() async {
    if (!GradeDatasetClient.instance.isDatasetLoaded) {
      print('not loaded');
      bool isFileOnDevice = await GradeDatasetClient.instance.isSavedOnDevice();
      if (isFileOnDevice) {
        print('file is on device, reading from file');
        await GradeDatasetClient.instance.readFromFile();
      } else {
        print('file is not on device, beginning download');
        setState(() {
          _loadingStatus = LoadingStatus.downloadingFile;
        });
        await GradeDatasetClient.instance.downloadFromServer((newProgress) {
          setState(() {
            _progress = newProgress;
          });
        });
      }
    }
    setState(() {
      _loadingStatus = LoadingStatus.complete;
    });
  }

  Widget buildLoadingView(BuildContext context) {
    return LoadingView(status: _loadingStatus, progress: _progress);
  }

  @override
  Widget build(BuildContext context) {
    print(
        'isDatasetLoaded: ${GradeDatasetClient.instance.isDatasetLoaded}, loadingStatus: $_loadingStatus');
    if (GradeDatasetClient.instance.isDatasetLoaded ||
        _loadingStatus == LoadingStatus.complete) {
      return widget.bottomLayer;
    }
    return buildLoadingView(context);
  }
}
