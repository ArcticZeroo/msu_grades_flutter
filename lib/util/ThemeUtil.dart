import 'package:flutter/painting.dart';

abstract class ThemeUtil {
  static Color dimColor(Color color, int amount) {
    return Color.fromARGB(color.alpha, color.red - amount, color.green - amount,
        color.blue - amount);
  }
}
