import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyListWidget({
    super.key,
    required this.message,
    this.icon = Icons.restaurant_menu,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: ColorSet.disabled),
            SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: ColorSet.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
