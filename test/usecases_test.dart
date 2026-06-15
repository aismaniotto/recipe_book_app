import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';

import 'helpers/fake_recipe_repository.dart';

void main() {
  late FakeRecipeRepository repository;

  setUp(() {
    repository = FakeRecipeRepository();
  });

  group('AddRecipe', () {
    late AddRecipe usecase;
    setUp(() => usecase = AddRecipe(repostitory: repository));

    test('delega para o repositório e retorna a receita', () async {
      final recipe = Recipe(title: 'Bolo');
      final result = await usecase(recipe);

      expect(result.title, 'Bolo');
      expect(repository.addCallCount, 1);
      expect(repository.lastSaved?.title, 'Bolo');
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
    setUp(() => usecase = UpdateRecipe(repostitory: repository));

    test('delega para o repositório e retorna a receita atualizada', () async {
      final recipe = Recipe(id: 'r1', title: 'Original');
      repository.recipes = [recipe];

      recipe.title = 'Atualizado';
      final result = await usecase(recipe);

      expect(result.title, 'Atualizado');
      expect(repository.updateCallCount, 1);
    });
  });

  group('DeleteRecipe', () {
    late DeleteRecipe usecase;
    setUp(() => usecase = DeleteRecipe(repostitory: repository));

    test('delega para o repositório com o id correto', () async {
      final recipe = Recipe(id: 'to-delete', title: 'Deletar');
      repository.recipes = [recipe];

      await usecase(recipe);

      expect(repository.deleteCallCount, 1);
      expect(repository.lastDeletedId, 'to-delete');
      expect(repository.recipes, isEmpty);
    });
  });

  group('GetAllRecipes', () {
    late GetAllRecipes usecase;
    setUp(() => usecase = GetAllRecipes(repostitory: repository));

    test('retorna todas as receitas do repositório', () async {
      repository.recipes = [
        Recipe(title: 'A'),
        Recipe(title: 'B'),
        Recipe(title: 'C'),
      ];

      final result = await usecase();

      expect(result.length, 3);
      expect(repository.getAllCallCount, 1);
    });

    test('retorna lista vazia quando não há receitas', () async {
      final result = await usecase();
      expect(result, isEmpty);
    });
  });

  group('GetRecipe', () {
    late GetRecipe usecase;
    setUp(() => usecase = GetRecipe(repostitory: repository));

    test('retorna receita pelo id', () async {
      final recipe = Recipe(id: 'find-me', title: 'Encontrada');
      repository.recipes = [
        Recipe(title: 'Outra'),
        recipe,
      ];

      final result = await usecase('find-me');

      expect(result.title, 'Encontrada');
      expect(repository.getByIdCallCount, 1);
    });
  });
}
