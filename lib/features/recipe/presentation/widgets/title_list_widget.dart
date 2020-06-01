import 'package:flutter/material.dart';

class TitleListWidget extends StatelessWidget {
  final String title;

  const TitleListWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
