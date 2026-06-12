import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

void main() {
  group('Recipe', () {
    test('aplica valores padrão quando criada sem argumentos', () {
      final recipe = Recipe();

      expect(recipe.id, isNotEmpty);
      expect(recipe.title, '');
      expect(recipe.description, isNull);
      expect(recipe.type, Type.other);
      expect(recipe.difficulty, Difficulty.easy);
      expect(recipe.quantityPeopleServide, isNull);
      expect(recipe.ingredientList, isEmpty);
      expect(recipe.steps, isEmpty);
    });

    test('preserva os valores informados', () {
      final recipe = Recipe(
        title: 'Bolo de cenoura',
        description: 'Clássico',
        type: Type.dessert,
        difficulty: Difficulty.medium,
        quantityPeopleServide: 8,
      );

      expect(recipe.title, 'Bolo de cenoura');
      expect(recipe.description, 'Clássico');
      expect(recipe.type, Type.dessert);
      expect(recipe.difficulty, Difficulty.medium);
      expect(recipe.quantityPeopleServide, 8);
    });

    test('gera um id único para cada receita', () {
      expect(Recipe().id, isNot(equals(Recipe().id)));
    });
  });
}
