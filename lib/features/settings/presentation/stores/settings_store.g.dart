// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  late final _$themeColorAtom = Atom(
    name: '_SettingsStore.themeColor',
    context: context,
  );

  @override
  Color get themeColor {
    _$themeColorAtom.reportRead();
    return super.themeColor;
  }

  @override
  set themeColor(Color value) {
    _$themeColorAtom.reportWrite(value, super.themeColor, () {
      super.themeColor = value;
    });
  }

  late final _$themeModeAtom = Atom(
    name: '_SettingsStore.themeMode',
    context: context,
  );

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$loadSettingsAsyncAction = AsyncAction(
    '_SettingsStore.loadSettings',
    context: context,
  );

  @override
  Future<void> loadSettings() {
    return _$loadSettingsAsyncAction.run(() => super.loadSettings());
  }

  late final _$setThemeColorAsyncAction = AsyncAction(
    '_SettingsStore.setThemeColor',
    context: context,
  );

  @override
  Future<void> setThemeColor(Color color) {
    return _$setThemeColorAsyncAction.run(() => super.setThemeColor(color));
  }

  late final _$setThemeModeAsyncAction = AsyncAction(
    '_SettingsStore.setThemeMode',
    context: context,
  );

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(mode));
  }

  @override
  String toString() {
    return '''
themeColor: ${themeColor},
themeMode: ${themeMode}
    ''';
  }
}
