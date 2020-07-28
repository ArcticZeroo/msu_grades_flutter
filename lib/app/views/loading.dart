import 'package:flutter/material.dart';
import 'package:msu_grades/util/ListUtil.dart';
import 'package:msu_grades/util/ThemeUtil.dart';

enum LoadingStatus { fetchingMetadata, downloadingFile, complete, failed }

class LoadingView extends StatelessWidget {
  final LoadingStatus status;
  final double progress;
  final TextStyle textStyle = TextStyle(fontSize: 24.0);

  LoadingView({@required this.status, this.progress = 0.0});

  Widget buildBody() {
    List<Widget> children = [];

    return Column(
      children: children,
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    List<Widget> unseparatedChildren = [];

    if (status == LoadingStatus.downloadingFile) {
      unseparatedChildren.addAll([
        Text('Downloading grade data...', style: textStyle),
        LinearProgressIndicator(value: progress)
      ]);
    } else if (status == LoadingStatus.fetchingMetadata) {
      unseparatedChildren.addAll(
          [Text('Fetching file metadata...'), CircularProgressIndicator()]);
    } else if (status == LoadingStatus.complete) {
      unseparatedChildren.addAll([
        Text('Download complete!', style: textStyle),
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          child: Icon(Icons.check),
          height: 32.0,
          width: 32.0,
        )
      ]);
    } else if (status == LoadingStatus.failed) {
      unseparatedChildren.addAll([
        Text('Download failed', style: textStyle),
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Icon(Icons.close),
          height: 32.0,
          width: 32.0,
        )
      ]);
    }

    return ListUtil.separate(unseparatedChildren, () => SizedBox(height: 8.0));
  }

  Widget buildLoadingStateCard(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildChildren(context),
          ),
        ),
      ),
    );
  }

  Widget buildDimBackground(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: ThemeUtil.dimColor(Theme.of(context).backgroundColor, 25)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [buildDimBackground(context), buildLoadingStateCard(context)],
      ),
    );
  }
}
