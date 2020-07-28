import 'dart:io';

abstract class FileUtil {
  static Future<bool> exists(String path) {
    return File(path).exists();
  }
}
