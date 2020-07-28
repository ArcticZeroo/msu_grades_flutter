import 'package:flutter/material.dart';

enum LoadingStatus { fetchingMetadata, downloadingFile }

class LoadingView extends StatelessWidget {
  final LoadingStatus status;
  final double progress;

  LoadingView({@required this.status, this.progress = 0.0});

  Widget buildBody() {
    List<Widget> children = [];

    return Column(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Column(
        children: [
          Text('Downloading data...'),
          SizedBox(
            height: 8.0,
          ),
          LinearProgressIndicator(value: progress)
        ],
      ),
    );
  }
}
