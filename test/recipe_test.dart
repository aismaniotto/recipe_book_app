import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';

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
      expect(recipe.isFavorite, false);
      expect(recipe.prepTimeMinutes, isNull);
    });

    test('preserva os valores informados', () {
      final recipe = Recipe(
        title: 'Bolo de cenoura',
        description: 'Clássico',
        type: Type.dessert,
        difficulty: Difficulty.medium,
        quantityPeopleServide: 8,
        isFavorite: true,
        prepTimeMinutes: 45,
      );

      expect(recipe.title, 'Bolo de cenoura');
      expect(recipe.description, 'Clássico');
      expect(recipe.type, Type.dessert);
      expect(recipe.difficulty, Difficulty.medium);
      expect(recipe.quantityPeopleServide, 8);
      expect(recipe.isFavorite, true);
      expect(recipe.prepTimeMinutes, 45);
    });

    test('gera um id único para cada receita', () {
      expect(Recipe().id, isNot(equals(Recipe().id)));
    });

    test('aceita id fornecido', () {
      final recipe = Recipe(id: 'custom-id');
      expect(recipe.id, 'custom-id');
    });

    test('isFavorite padrão é false quando null é passado', () {
      final recipe = Recipe(isFavorite: null);
      expect(recipe.isFavorite, false);
    });

    test('aceita lista de ingredientes e passos', () {
      final ingredients = [
        IdentificableText('Farinha'),
        IdentificableText('Açúcar'),
      ];
      final steps = [
        IdentificableText('Misturar'),
      ];
      final recipe = Recipe(ingredientList: ingredients, steps: steps);

      expect(recipe.ingredientList.length, 2);
      expect(recipe.steps.length, 1);
      expect(recipe.ingredientList[0].text, 'Farinha');
      expect(recipe.steps[0].text, 'Misturar');
    });
  });

  group('IdentificableText', () {
    test('armazena texto', () {
      final text = IdentificableText('Farinha');
      expect(text.text, 'Farinha');
    });

    test('aceita id fornecido', () {
      final text = IdentificableText('Açúcar', id: 'custom-id');
      expect(text.text, 'Açúcar');
      expect(text.id, 'custom-id');
    });

    test('toString retorna o texto', () {
      final text = IdentificableText('Sal');
      expect(text.toString(), 'Sal');
    });

    test('toString retorna string vazia quando text é null', () {
      final text = IdentificableText(null);
      expect(text.toString(), '');
    });
  });
}
