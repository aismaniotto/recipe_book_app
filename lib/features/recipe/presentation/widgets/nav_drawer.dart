import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class NavDrawer extends StatelessWidget {
  final NavigationService navigationService;
  final VoidCallback? onReturn;

  const NavDrawer({super.key, required this.navigationService, this.onReturn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            child: Text(
              LocaleKeys.recipe_book.tr(),
              style: TextStyle(color: ColorSet.textOnPrimary, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text(LocaleKeys.settings_data.tr()),
            onTap: () {
              Navigator.of(context).pop();
              navigationService.navigateTo('/data_management').whenComplete(() {
                onReturn?.call();
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(LocaleKeys.settings.tr()),
            onTap: () {
              Navigator.of(context).pop();
              navigationService.navigateTo('/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(LocaleKeys.about.tr()),
            onTap: () {
              Navigator.of(context).pop();
              navigationService.navigateTo('/about');
            },
          ),
        ],
      ),
    );
  }
}
