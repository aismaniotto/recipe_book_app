import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/utils/recipe_formatter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

// RecipeFormatter depends on easy_localization .tr() which requires
// a running app context. We test the structure/logic by checking that
// the output contains expected content from the recipe fields.
// The .tr() calls will return the key itself in test environment.

void main() {
  group('RecipeFormatter.toShareText', () {
    test('inclui título em maiúsculas', () {
      final recipe = Recipe(title: 'Bolo de chocolate');
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('BOLO DE CHOCOLATE'));
    });

    test('inclui ingredientes com bullet points', () {
      final recipe = Recipe(
        title: 'Bolo',
        ingredientList: [
          IdentificableText('Farinha'),
          IdentificableText('Açúcar'),
        ],
      );
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('• Farinha'));
      expect(text, contains('• Açúcar'));
    });

    test('inclui passos numerados', () {
      final recipe = Recipe(
        title: 'Bolo',
        steps: [
          IdentificableText('Misturar'),
          IdentificableText('Assar'),
        ],
      );
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('1. Misturar'));
      expect(text, contains('2. Assar'));
    });

    test('inclui descrição quando presente', () {
      final recipe = Recipe(title: 'Bolo', description: 'Delicioso');
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('Delicioso'));
    });

    test('não inclui descrição quando vazia', () {
      final recipe = Recipe(title: 'Bolo', description: '');
      final text = RecipeFormatter.toShareText(recipe);

      // Should not have an empty description line
      expect(text, isNot(contains(': \n')));
    });

    test('inclui quantidade de pessoas quando presente', () {
      final recipe = Recipe(title: 'Bolo', quantityPeopleServide: 8);
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('8'));
    });

    test('inclui tempo de preparo quando presente', () {
      final recipe = Recipe(title: 'Bolo', prepTimeMinutes: 45);
      final text = RecipeFormatter.toShareText(recipe);

      // In test env, .tr() returns the key; the line should still be present
      expect(text, contains('prep_time'));
    });

    test('não inclui tempo de preparo quando null', () {
      final recipe = Recipe(title: 'Bolo');
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, isNot(contains('prep_time')));
    });

    test('ignora ingredientes vazios', () {
      final recipe = Recipe(
        title: 'Bolo',
        ingredientList: [
          IdentificableText('Farinha'),
          IdentificableText(''),
          IdentificableText('Açúcar'),
        ],
      );
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('• Farinha'));
      expect(text, contains('• Açúcar'));
      expect(text, isNot(contains('• \n')));
    });

    test('ignora passos vazios', () {
      final recipe = Recipe(
        title: 'Bolo',
        steps: [
          IdentificableText('Misturar'),
          IdentificableText(''),
        ],
      );
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('1. Misturar'));
      expect(text, isNot(contains('2.')));
    });

    test('receita completa gera texto estruturado', () {
      final recipe = Recipe(
        title: 'Cookies',
        description: 'Crocantes',
        type: Type.snack,
        difficulty: Difficulty.medium,
        quantityPeopleServide: 10,
        prepTimeMinutes: 30,
        ingredientList: [
          IdentificableText('Farinha'),
          IdentificableText('Manteiga'),
        ],
        steps: [
          IdentificableText('Misturar'),
          IdentificableText('Assar'),
        ],
      );
      final text = RecipeFormatter.toShareText(recipe);

      expect(text, contains('COOKIES'));
      expect(text, contains('Crocantes'));
      expect(text, contains('10'));
      expect(text, contains('prep_time'));
      expect(text, contains('• Farinha'));
      expect(text, contains('• Manteiga'));
      expect(text, contains('1. Misturar'));
      expect(text, contains('2. Assar'));
    });
  });
}
