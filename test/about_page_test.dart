import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/about/presentation/pages/about_page.dart';

void main() {
  group('AboutPage', () {
    test('é um StatelessWidget', () {
      expect(AboutPage(), isA<StatelessWidget>());
    });

    test('pode ser instanciado', () {
      const page = AboutPage();
      expect(page, isNotNull);
    });
  });
}
