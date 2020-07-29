import 'package:flutter/material.dart';
import 'package:msu_grades/api/data/grades/search/search_delegate.dart';
import 'package:msu_grades/app/views/settings/checkbox.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isInstructorSearchEnabled = true;
  bool _isCourseSearchEnabled = true;

  void searchCallback(BuildContext context) {
    showSearch(delegate: GradeDatasetSearchDelegate(), context: context);
  }

  Widget buildSearchButton(BuildContext context) {
    return InkWell(
//        textColor: Theme.of(context).accentColor,
        // Theme.color.of(context).primaryTextTheme.bodyText2,
        onTap: () {
          searchCallback(context);
        },
        child: DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).accentColor),
          child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search MSU Grades",
                    textScaleFactor: 2.0,
                  ),
                  SizedBox(width: 12.0),
                  Icon(Icons.search,
                      size: (Theme.of(context).iconTheme.size ?? 24.0) * 1.5)
                ],
              )),
        ));
  }

  Widget buildSettings(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('Search Settings',
                style: Theme.of(context).textTheme.subtitle1),
            SettingsCheckbox(
              labelText: 'Instructors',
              isChecked: _isInstructorSearchEnabled,
              onChanged: (isInstructorSearchEnabled) {
                setState(() {
                  _isInstructorSearchEnabled = isInstructorSearchEnabled;
                });
              },
            ),
            SettingsCheckbox(
              labelText: 'Courses',
              isChecked: _isCourseSearchEnabled,
              onChanged: (isCourseSearchEnabled) {
                setState(() {
                  _isCourseSearchEnabled = isCourseSearchEnabled;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSearchButton(context),
          buildSettings(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MSU Grades')), body: buildBody(context));
  }
}
