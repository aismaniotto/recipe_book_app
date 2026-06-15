import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/theme/app_text_styles.dart';
import 'package:recipe_book_app/core/theme/app_theme.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

void main() {
  group('ColorSet', () {
    test('primary é vermelho', () {
      expect(ColorSet.primary, Color(0xFFF44336));
    });

    test('background é cinza claro', () {
      expect(ColorSet.background, Color(0xFFEFEFEF));
    });

    test('todas as cores estão definidas', () {
      expect(ColorSet.primary, isNotNull);
      expect(ColorSet.primaryDark, isNotNull);
      expect(ColorSet.primaryLight, isNotNull);
      expect(ColorSet.secondary, isNotNull);
      expect(ColorSet.secondaryLight, isNotNull);
      expect(ColorSet.background, isNotNull);
      expect(ColorSet.surface, isNotNull);
      expect(ColorSet.success, isNotNull);
      expect(ColorSet.attention, isNotNull);
      expect(ColorSet.error, isNotNull);
      expect(ColorSet.textPrimary, isNotNull);
      expect(ColorSet.textSecondary, isNotNull);
      expect(ColorSet.textOnPrimary, isNotNull);
      expect(ColorSet.divider, isNotNull);
      expect(ColorSet.favorite, isNotNull);
    });
  });

  group('AppTextStyles', () {
    test('headline1 é bold e grande', () {
      expect(AppTextStyles.headline1.fontSize, 28);
      expect(AppTextStyles.headline1.fontWeight, FontWeight.bold);
    });

    test('body tem tamanho 16', () {
      expect(AppTextStyles.body.fontSize, 16);
    });

    test('caption é menor', () {
      expect(AppTextStyles.caption.fontSize, 12);
    });

    test('todos os estilos estão definidos', () {
      expect(AppTextStyles.headline1, isNotNull);
      expect(AppTextStyles.headline2, isNotNull);
      expect(AppTextStyles.headline3, isNotNull);
      expect(AppTextStyles.body, isNotNull);
      expect(AppTextStyles.bodySmall, isNotNull);
      expect(AppTextStyles.caption, isNotNull);
      expect(AppTextStyles.label, isNotNull);
    });
  });

  group('AppTheme', () {
    test('light() retorna ThemeData', () {
      final theme = AppTheme.light();
      expect(theme, isA<ThemeData>());
    });

    test('scaffoldBackgroundColor usa ColorSet.background', () {
      expect(AppTheme.light().scaffoldBackgroundColor, ColorSet.background);
    });

    test('appBar usa primary como background por padrão', () {
      expect(AppTheme.light().appBarTheme.backgroundColor, ColorSet.primary);
    });

    test('appBar usa textOnPrimary como foreground', () {
      expect(AppTheme.light().appBarTheme.foregroundColor, ColorSet.textOnPrimary);
    });

    test('aceita cor primária customizada', () {
      final theme = AppTheme.light(primaryColor: Colors.blue);
      expect(theme.appBarTheme.backgroundColor, Colors.blue);
    });

    test('FAB usa cor primária customizada', () {
      final theme = AppTheme.light(primaryColor: Colors.green);
      expect(theme.floatingActionButtonTheme.backgroundColor, Colors.green);
    });

    test('light tem brightness light', () {
      expect(AppTheme.light().brightness, Brightness.light);
    });
  });

  group('AppTheme.dark', () {
    test('dark() retorna ThemeData', () {
      expect(AppTheme.dark(), isA<ThemeData>());
    });

    test('dark tem brightness dark', () {
      expect(AppTheme.dark().brightness, Brightness.dark);
    });

    test('dark appBar usa primary como background', () {
      expect(AppTheme.dark().appBarTheme.backgroundColor, ColorSet.primary);
    });

    test('dark aceita cor primária customizada', () {
      final theme = AppTheme.dark(primaryColor: Colors.purple);
      expect(theme.appBarTheme.backgroundColor, Colors.purple);
    });
  });

  group('AppTheme fontScale', () {
    test('light com fontScale 1.0 mantém tamanhos padrão', () {
      final theme = AppTheme.light(fontScale: 1.0);
      expect(theme.textTheme.bodyMedium?.fontSize, 16.0);
    });

    test('light com fontScale maior aumenta tamanhos', () {
      final theme = AppTheme.light(fontScale: 1.2);
      expect(theme.textTheme.bodyMedium?.fontSize, closeTo(19.2, 0.1));
      expect(theme.textTheme.headlineLarge?.fontSize, closeTo(33.6, 0.1));
    });

    test('light com fontScale menor diminui tamanhos', () {
      final theme = AppTheme.light(fontScale: 0.85);
      expect(theme.textTheme.bodyMedium?.fontSize, closeTo(13.6, 0.1));
    });

    test('dark com fontScale aplica escala', () {
      final theme = AppTheme.dark(fontScale: 1.2);
      expect(theme.textTheme.bodyMedium?.fontSize, closeTo(19.2, 0.1));
    });
  });
}
