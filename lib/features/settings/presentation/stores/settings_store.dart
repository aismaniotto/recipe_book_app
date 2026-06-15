import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

const List<Color> availableThemeColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.orange,
  Colors.brown,
  Colors.blueGrey,
];

class SettingsStore extends _SettingsStore with _$SettingsStore {
  SettingsStore();
}

abstract class _SettingsStore with Store {
  static const _themeColorKey = 'theme_color';

  @observable
  Color themeColor = Colors.red;

  @action
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_themeColorKey);
    if (colorValue != null) {
      themeColor = Color(colorValue);
    }
  }

  @action
  Future<void> setThemeColor(Color color) async {
    themeColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, color.toARGB32());
  }
}
