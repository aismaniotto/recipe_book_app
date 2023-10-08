import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              LocaleKeys.recipe_book.tr(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text(
              LocaleKeys.backup.tr(),
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              LocaleKeys.about.tr(),
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
