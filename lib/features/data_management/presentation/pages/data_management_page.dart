import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/file_picker_service.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';
import 'package:recipe_book_app/core/widgets/snack_bar_helper.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/export_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/import_recipes.dart';
import 'package:share_plus/share_plus.dart';

class DataManagementPage extends StatelessWidget {
  const DataManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_data.tr()),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.upload),
            title: Text(LocaleKeys.settings_export.tr()),
            subtitle: Text(LocaleKeys.settings_export_description.tr()),
            onTap: () => _exportRecipes(context),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.download),
            title: Text(LocaleKeys.settings_import.tr()),
            subtitle: Text(LocaleKeys.settings_import_description.tr()),
            onTap: () => _importRecipes(context),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.delete_forever, color: ColorSet.error),
            title: Text(
              LocaleKeys.settings_delete_all.tr(),
              style: TextStyle(color: ColorSet.error),
            ),
            subtitle: Text(LocaleKeys.settings_delete_all_description.tr()),
            onTap: () => _deleteAllRecipes(context),
          ),
        ],
      ),
    );
  }

  Future<void> _exportRecipes(BuildContext context) async {
    final result = await ioc<ExportRecipes>()();
    result.fold(
      (failure) => SnackBarHelper.showError(context, LocaleKeys.error_generic.tr()),
      (json) async {
        final dir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${dir.path}/recipes_backup_$timestamp.json');
        await file.writeAsString(json);
        await Share.shareXFiles([XFile(file.path)]);
        if (context.mounted) {
          SnackBarHelper.showSuccess(context, LocaleKeys.settings_export_success.tr());
        }
      },
    );
  }

  Future<void> _importRecipes(BuildContext context) async {
    final jsonString = await FilePickerService.pickJsonFile();

    if (jsonString == null || jsonString.isEmpty) return;

    final result = await ioc<ImportRecipes>()(jsonString);
    if (!context.mounted) return;
    result.fold(
      (failure) => SnackBarHelper.showError(context, LocaleKeys.error_generic.tr()),
      (count) => SnackBarHelper.showSuccess(
        context,
        LocaleKeys.settings_import_success.tr(namedArgs: {'count': count.toString()}),
      ),
    );
  }

  Future<void> _deleteAllRecipes(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(LocaleKeys.attention.tr()),
        content: Text(LocaleKeys.settings_delete_all_confirm.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(LocaleKeys.no.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              LocaleKeys.yes.tr(),
              style: TextStyle(color: ColorSet.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final result = await ioc<DeleteAllRecipes>()();
    if (!context.mounted) return;
    result.fold(
      (failure) => SnackBarHelper.showError(context, LocaleKeys.error_generic.tr()),
      (_) => SnackBarHelper.showSuccess(context, LocaleKeys.settings_delete_all_success.tr()),
    );
  }
}
