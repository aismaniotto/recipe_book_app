import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/list_recipes_page.dart';
import 'package:recipe_book_app/core/localization_generated/codegen_loader.g.dart';

void main() async {
  await ioc.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('pt')],
        path: 'assets/lang',
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.recipe_book,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
          textTheme: TextTheme(bodyText2: TextStyle(fontSize: 16.0))),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: ListRecipesPage(),
    );
  }
}
