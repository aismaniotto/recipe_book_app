import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/app_text_styles.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class AppTheme {
  static TextTheme _scaledTextTheme(double scale) {
    return TextTheme(
      headlineLarge: AppTextStyles.headline1.copyWith(
          fontSize: AppTextStyles.headline1.fontSize! * scale),
      headlineMedium: AppTextStyles.headline2.copyWith(
          fontSize: AppTextStyles.headline2.fontSize! * scale),
      headlineSmall: AppTextStyles.headline3.copyWith(
          fontSize: AppTextStyles.headline3.fontSize! * scale),
      bodyLarge: AppTextStyles.body.copyWith(
          fontSize: AppTextStyles.body.fontSize! * scale),
      bodyMedium: AppTextStyles.body.copyWith(
          fontSize: AppTextStyles.body.fontSize! * scale),
      bodySmall: AppTextStyles.bodySmall.copyWith(
          fontSize: AppTextStyles.bodySmall.fontSize! * scale),
      labelLarge: AppTextStyles.label.copyWith(
          fontSize: AppTextStyles.label.fontSize! * scale),
      labelSmall: AppTextStyles.caption.copyWith(
          fontSize: AppTextStyles.caption.fontSize! * scale),
    );
  }

  static ThemeData light({Color? primaryColor, double fontScale = 1.0}) {
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
      textTheme: _scaledTextTheme(fontScale),
    );
  }

  static ThemeData dark({Color? primaryColor, double fontScale = 1.0}) {
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
      textTheme: _scaledTextTheme(fontScale),
    );
  }
}
