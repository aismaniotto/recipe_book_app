import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/app_text_styles.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorSchemeSeed: ColorSet.primary,
        scaffoldBackgroundColor: ColorSet.background,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorSet.primary,
          foregroundColor: ColorSet.textOnPrimary,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: ColorSet.textOnPrimary,
          unselectedLabelColor: ColorSet.textOnPrimary.withValues(alpha: 0.7),
          indicatorColor: ColorSet.textOnPrimary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorSet.primary,
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
