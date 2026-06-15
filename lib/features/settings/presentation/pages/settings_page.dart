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
            Text(
              LocaleKeys.settings_theme_color.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
            SizedBox(height: 12),
            Observer(
              builder: (_) => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: availableThemeColors.map((color) {
                  final isSelected = store.themeColor.toARGB32() == color.toARGB32();
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
                            ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 2)]
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
            Text(
              LocaleKeys.settings_language.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
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
