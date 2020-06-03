import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class EmptyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(LocaleKeys.no_recipe_add_yet.tr()),
    );
  }
}
