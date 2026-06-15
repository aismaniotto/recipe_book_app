import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/app_text_styles.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class AppTheme {
  static ThemeData light({Color? primaryColor}) {
    final primary = primaryColor ?? ColorSet.primary;

    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: primary,
      scaffoldBackgroundColor: ColorSet.background,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: ColorSet.textOnPrimary,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: ColorSet.textOnPrimary,
        unselectedLabelColor: ColorSet.textOnPrimary.withValues(alpha: 0.7),
        indicatorColor: ColorSet.textOnPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: ColorSet.textOnPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headline1,
        headlineMedium: AppTextStyles.headline2,
        headlineSmall: AppTextStyles.headline3,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.label,
        labelSmall: AppTextStyles.caption,
      ),
    );
  }

  static ThemeData dark({Color? primaryColor}) {
    final primary = primaryColor ?? ColorSet.primary;

    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: primary,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: ColorSet.textOnPrimary,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: ColorSet.textOnPrimary,
        unselectedLabelColor: ColorSet.textOnPrimary.withValues(alpha: 0.7),
        indicatorColor: ColorSet.textOnPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: ColorSet.textOnPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(),
      ),
    );
  }
}
