import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

enum FontScale {
  small(0.85),
  medium(1.0),
  large(1.2);

  final double value;
  const FontScale(this.value);
}

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
  static const _themeModeKey = 'theme_mode';
  static const _fontScaleKey = 'font_scale';
  static const _defaultSortKey = 'default_sort';

  @observable
  Color themeColor = Colors.red;

  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  FontScale fontScale = FontScale.medium;

  @observable
  SortOption defaultSortOption = SortOption.name;

  @action
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_themeColorKey);
    if (colorValue != null) {
      themeColor = Color(colorValue);
    }
    final modeIndex = prefs.getInt(_themeModeKey);
    if (modeIndex != null) {
      themeMode = ThemeMode.values[modeIndex];
    }
    final scaleIndex = prefs.getInt(_fontScaleKey);
    if (scaleIndex != null) {
      fontScale = FontScale.values[scaleIndex];
    }
    final sortIndex = prefs.getInt(_defaultSortKey);
    if (sortIndex != null) {
      defaultSortOption = SortOption.values[sortIndex];
    }
  }

  @action
  Future<void> setThemeColor(Color color) async {
    themeColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, color.toARGB32());
  }

  @action
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  @action
  Future<void> setFontScale(FontScale scale) async {
    fontScale = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_fontScaleKey, scale.index);
  }

  @action
  Future<void> setDefaultSortOption(SortOption option) async {
    defaultSortOption = option;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_defaultSortKey, option.index);
  }

}
