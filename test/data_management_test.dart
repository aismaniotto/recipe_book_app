import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/identificable_text_adapater.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/export_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/import_recipes.dart';

import 'helpers/fake_recipe_repository.dart';

void main() {
  late FakeRecipeRepository repository;
  late RecipeAdapter adapter;

  setUp(() {
    repository = FakeRecipeRepository();
    adapter = RecipeAdapter(IdentificableTextAdapter());
  });

  group('ExportRecipes', () {
    late ExportRecipes usecase;
    setUp(() => usecase = ExportRecipes(repository: repository, adapter: adapter));

    test('retorna Right com JSON válido', () async {
      repository.recipes = [
        Recipe(id: 'r1', title: 'Bolo', type: Type.dessert),
        Recipe(id: 'r2', title: 'Sopa', type: Type.meal),
      ];

      final result = await usecase();

      expect(result.isRight(), true);
      result.fold((_) {}, (json) {
        final list = jsonDecode(json) as List;
        expect(list.length, 2);
        expect(list[0]['title'], 'Bolo');
        expect(list[1]['title'], 'Sopa');
      });
    });

    test('exporta receita completa com todos os campos', () async {
      repository.recipes = [
        Recipe(
          id: 'full',
          title: 'Completa',
          description: 'Desc',
          type: Type.snack,
          difficulty: Difficulty.hard,
          quantityPeopleServide: 4,
          prepTimeMinutes: 30,
          isFavorite: true,
          ingredientList: [IdentificableText('Farinha', id: 'i1')],
          steps: [IdentificableText('Misturar', id: 's1')],
        ),
      ];

      final result = await usecase();

      result.fold((_) {}, (json) {
        final list = jsonDecode(json) as List;
        final map = list[0] as Map<String, dynamic>;
        expect(map['isFavorite'], true);
        expect(map['prepTimeMinutes'], 30);
        expect(map['ingredientList'].length, 1);
        expect(map['steps'].length, 1);
      });
    });

    test('retorna Right com lista vazia quando não há receitas', () async {
      final result = await usecase();

      result.fold((_) {}, (json) {
        final list = jsonDecode(json) as List;
        expect(list, isEmpty);
      });
    });

    test('retorna Left quando repository falha', () async {
      repository.shouldFail = true;
      final result = await usecase();

      expect(result.isLeft(), true);
    });
  });

  group('ImportRecipes', () {
    late ImportRecipes usecase;
    setUp(() => usecase = ImportRecipes(repository: repository, adapter: adapter));

    test('importa receitas de JSON válido', () async {
      final json = jsonEncode([
        adapter.toMap(Recipe(title: 'Bolo')),
        adapter.toMap(Recipe(title: 'Sopa')),
      ]);

      final result = await usecase(json);

      expect(result.isRight(), true);
      result.fold((_) {}, (count) => expect(count, 2));
      expect(repository.recipes.length, 2);
    });

    test('retorna contagem correta de receitas importadas', () async {
      final json = jsonEncode([
        adapter.toMap(Recipe(title: 'A')),
        adapter.toMap(Recipe(title: 'B')),
        adapter.toMap(Recipe(title: 'C')),
      ]);

      final result = await usecase(json);

      result.fold((_) {}, (count) => expect(count, 3));
    });

    test('preserva todos os campos na importação', () async {
      final original = Recipe(
        title: 'Completa',
        description: 'Desc',
        type: Type.dessert,
        difficulty: Difficulty.hard,
        isFavorite: true,
        prepTimeMinutes: 45,
        ingredientList: [IdentificableText('Farinha', id: 'i1')],
        steps: [IdentificableText('Assar', id: 's1')],
      );
      final json = jsonEncode([adapter.toMap(original)]);

      await usecase(json);

      final imported = repository.recipes.first;
      expect(imported.title, 'Completa');
      expect(imported.type, Type.dessert);
      expect(imported.isFavorite, true);
      expect(imported.prepTimeMinutes, 45);
      expect(imported.ingredientList.length, 1);
      expect(imported.steps.length, 1);
    });

    test('retorna Left com JSON inválido', () async {
      final result = await usecase('isso não é json');

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<DatabaseFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('retorna Left com JSON vazio', () async {
      final result = await usecase('');

      expect(result.isLeft(), true);
    });
  });

  group('DeleteAllRecipes', () {
    late DeleteAllRecipes usecase;
    setUp(() => usecase = DeleteAllRecipes(repository: repository));

    test('apaga todas as receitas', () async {
      repository.recipes = [
        Recipe(title: 'A'),
        Recipe(title: 'B'),
        Recipe(title: 'C'),
      ];

      final result = await usecase();

      expect(result.isRight(), true);
      expect(repository.recipes, isEmpty);
    });

    test('funciona quando não há receitas', () async {
      final result = await usecase();

      expect(result.isRight(), true);
    });

    test('retorna Left quando repository falha', () async {
      repository.shouldFail = true;
      final result = await usecase();

      expect(result.isLeft(), true);
    });
  });
}
