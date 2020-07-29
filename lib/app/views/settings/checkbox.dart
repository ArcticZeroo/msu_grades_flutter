import 'package:flutter/material.dart';

class SettingsCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String labelText;

  SettingsCheckbox(
      {@required this.isChecked,
      @required this.onChanged,
      @required this.labelText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(value: isChecked, onChanged: onChanged),
          Text(labelText)
        ],
      ),
    );
  }
}
