import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/features/settings/presentation/stores/settings_store.dart';

class SettingsPage extends StatelessWidget {
  final SettingsStore store;

  const SettingsPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(LocaleKeys.settings_dark_mode.tr()),
            SizedBox(height: 12),
            Observer(
              builder: (_) => SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode),
                    label: Text(LocaleKeys.settings_dark_mode_light.tr()),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.settings_brightness),
                    label: Text(LocaleKeys.settings_dark_mode_system.tr()),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode),
                    label: Text(LocaleKeys.settings_dark_mode_dark.tr()),
                  ),
                ],
                selected: {store.themeMode},
                onSelectionChanged: (selection) =>
                    store.setThemeMode(selection.first),
              ),
            ),
            SizedBox(height: 32),
            _SectionTitle(LocaleKeys.settings_theme_color.tr()),
            SizedBox(height: 12),
            Observer(
              builder: (_) => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: availableThemeColors.map((color) {
                  final isSelected =
                      store.themeColor.toARGB32() == color.toARGB32();
                  return GestureDetector(
                    onTap: () => store.setThemeColor(color),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    spreadRadius: 2)
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 24)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 32),
            _SectionTitle(LocaleKeys.settings_language.tr()),
            SizedBox(height: 12),
            ..._buildLanguageOptions(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLanguageOptions(BuildContext context) {
    final languages = [
      ('English', Locale('en')),
      ('Português', Locale('pt')),
      ('Español', Locale('es')),
      ('Italiano', Locale('it')),
      ('Deutsch', Locale('de')),
      ('Русский', Locale('ru')),
    ];

    return languages.map((lang) {
      final isSelected = context.locale == lang.$2;
      return ListTile(
        title: Text(lang.$1),
        leading: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
        onTap: () => context.setLocale(lang.$2),
      );
    }).toList();
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodySmall?.color),
    );
  }
}
