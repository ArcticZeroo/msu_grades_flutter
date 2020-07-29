import 'package:flutter/material.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';

class GradeDatasetSearchDelegate extends SearchDelegate {
  List<Result> getFuzzyResults() {
    return Fuzzy([]).search(query);
  }

  List<Widget> getMsuObjects(List<Result> results) {
    List<Widget> to_display;
    for (int i = 0; i < results.length; i++) {
      to_display.add(results[i].item.displayDuringLookup());
    }
    return to_display;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // TODO: implement buildSuggestions
    // list view, get from fuzzy
    return ListView(
        padding: EdgeInsets.all(4),
        children: getMsuObjects(getFuzzyResults()) // come from fuzzy
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // list view, get from fuzzy
    return ListView(
        padding: EdgeInsets.all(4),
        children: getMsuObjects(getFuzzyResults()) // come from fuzzy
        );
  }
}
