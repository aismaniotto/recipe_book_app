import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';

import 'helpers/fake_recipe_repository.dart';

void main() {
  late FakeRecipeRepository repository;

  setUp(() {
    repository = FakeRecipeRepository();
  });

  group('AddRecipe', () {
    late AddRecipe usecase;
    setUp(() => usecase = AddRecipe(repository: repository));

    test('retorna Right com receita em caso de sucesso', () async {
      final recipe = Recipe(title: 'Bolo');
      final result = await usecase(recipe);

      expect(result.isRight(), true);
      result.fold((_) {}, (r) => expect(r.title, 'Bolo'));
      expect(repository.addCallCount, 1);
    });

    test('retorna Left com Failure em caso de erro', () async {
      repository.shouldFail = true;
      final result = await usecase(Recipe(title: 'Falha'));

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<DatabaseFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('adiciona receita à lista do repositório', () async {
      await usecase(Recipe(title: 'A'));
      await usecase(Recipe(title: 'B'));

      expect(repository.recipes.length, 2);
      expect(repository.addCallCount, 2);
    });
  });

  group('UpdateRecipe', () {
    late UpdateRecipe usecase;
    setUp(() => usecase = UpdateRecipe(repository: repository));

    test('retorna Right com receita atualizada', () async {
      final recipe = Recipe(id: 'r1', title: 'Original');
      repository.recipes = [recipe];

      recipe.title = 'Atualizado';
      final result = await usecase(recipe);

      expect(result.isRight(), true);
      result.fold((_) {}, (r) => expect(r.title, 'Atualizado'));
      expect(repository.updateCallCount, 1);
    });

    test('retorna Left em caso de erro', () async {
      repository.shouldFail = true;
      final result = await usecase(Recipe(title: 'Falha'));

      expect(result.isLeft(), true);
    });
  });

  group('DeleteRecipe', () {
    late DeleteRecipe usecase;
    setUp(() => usecase = DeleteRecipe(repository: repository));

    test('retorna Right e remove do repositório', () async {
      final recipe = Recipe(id: 'to-delete', title: 'Deletar');
      repository.recipes = [recipe];

      final result = await usecase(recipe);

      expect(result.isRight(), true);
      expect(repository.deleteCallCount, 1);
      expect(repository.lastDeletedId, 'to-delete');
      expect(repository.recipes, isEmpty);
    });

    test('retorna Left em caso de erro', () async {
      repository.shouldFail = true;
      final result = await usecase(Recipe(title: 'Falha'));

      expect(result.isLeft(), true);
    });
  });

  group('GetAllRecipes', () {
    late GetAllRecipes usecase;
    setUp(() => usecase = GetAllRecipes(repository: repository));

    test('retorna Right com lista de receitas', () async {
      repository.recipes = [
        Recipe(title: 'A'),
        Recipe(title: 'B'),
        Recipe(title: 'C'),
      ];

      final result = await usecase();

      expect(result.isRight(), true);
      result.fold((_) {}, (list) => expect(list.length, 3));
      expect(repository.getAllCallCount, 1);
    });

    test('retorna Right com lista vazia quando não há receitas', () async {
      final result = await usecase();
      expect(result.isRight(), true);
      result.fold((_) {}, (list) => expect(list, isEmpty));
    });

    test('retorna Left em caso de erro', () async {
      repository.shouldFail = true;
      final result = await usecase();

      expect(result.isLeft(), true);
    });
  });

}
