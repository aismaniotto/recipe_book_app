import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';

class NavDrawer extends StatelessWidget {
  final NavigationService navigationService;

  const NavDrawer({super.key, required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              LocaleKeys.recipe_book.tr(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              LocaleKeys.about.tr(),
              style: TextStyle(fontSize: 18),
            ),
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
