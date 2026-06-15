import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/settings/presentation/stores/settings_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SettingsStore', () {
    late SettingsStore store;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      store = SettingsStore();
    });

    test('themeColor padrão é vermelho', () {
      expect(store.themeColor, Colors.red);
    });

    test('setThemeColor altera a cor e persiste', () async {
      await store.setThemeColor(Colors.blue);
      expect(store.themeColor, Colors.blue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('theme_color'), Colors.blue.toARGB32());
    });

    test('loadSettings restaura cor salva', () async {
      await store.setThemeColor(Colors.green);

      final newStore = SettingsStore();
      await newStore.loadSettings();

      expect(newStore.themeColor.toARGB32(), Colors.green.toARGB32());
    });

    test('loadSettings mantém padrão quando nada salvo', () async {
      await store.loadSettings();
      expect(store.themeColor, Colors.red);
    });
  });

  group('availableThemeColors', () {
    test('contém pelo menos 5 cores', () {
      expect(availableThemeColors.length, greaterThanOrEqualTo(5));
    });

    test('contém vermelho como primeira opção', () {
      expect(availableThemeColors.first, Colors.red);
    });

    test('todas são cores distintas', () {
      final values = availableThemeColors.map((c) => c.toARGB32()).toSet();
      expect(values.length, availableThemeColors.length);
    });
  });
}
