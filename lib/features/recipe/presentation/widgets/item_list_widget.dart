import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  final String data;
  final IconData iconData;
  final double iconSize;

  const ItemListWidget(this.data,
      {this.iconData = Icons.lens, this.iconSize = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: iconSize,
        ),
        SizedBox(width: 5.0),
        Flexible(
          child: Text(
            data,
            // style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
