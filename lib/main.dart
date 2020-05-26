import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;

import 'features/recipe/presentation/pages/home_page.dart';

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
      ),
      home: HomePage(),
    );
  }
}
