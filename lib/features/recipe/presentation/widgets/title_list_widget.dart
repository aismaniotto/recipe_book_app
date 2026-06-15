import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class TitleListWidget extends StatelessWidget {
  final String title;

  const TitleListWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Text(
        title,
        style: TextStyle(
            color: ColorSet.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
