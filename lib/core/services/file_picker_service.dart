import 'package:flutter/services.dart';

class FilePickerService {
  static const _channel = MethodChannel('recipe_book_app/file_picker');

  static Future<String?> pickJsonFile() async {
    try {
      final result = await _channel.invokeMethod<String>('pickJsonFile');
      return result;
    } catch (_) {
      return null;
    }
  }
}
