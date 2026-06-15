import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ColorSet.textPrimary,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ColorSet.textPrimary,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorSet.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: ColorSet.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: ColorSet.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: ColorSet.textSecondary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorSet.textSecondary,
  );
}
