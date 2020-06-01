import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;
import 'package:recipe_book_app/features/recipe/presentation/pages/list_recipes_page.dart';

void main() async {
  await ioc.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
          textTheme: TextTheme(bodyText2: TextStyle(fontSize: 16.0))),
      home: ListRecipesPage(),
    );
  }
}
