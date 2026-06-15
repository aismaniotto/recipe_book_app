import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

import 'helpers/fake_recipe_datasource.dart';

void main() {
  late RecipeRepositoryImpl repository;
  late FakeRecipeDataSource dataSource;

  setUp(() {
    dataSource = FakeRecipeDataSource();
    repository = RecipeRepositoryImpl(recipeDataSource: dataSource);
  });

  group('addRecipe', () {
    test('retorna Right com receita em caso de sucesso', () async {
      final recipe = Recipe(title: 'Bolo');
      final result = await repository.addRecipe(recipe);

      expect(result.isRight(), true);
      result.fold((_) {}, (r) => expect(r.title, 'Bolo'));
      expect(dataSource.recipes.length, 1);
    });

    test('retorna Left com DatabaseFailure quando data source lança exceção', () async {
      dataSource.shouldThrow = true;
      final result = await repository.addRecipe(Recipe(title: 'Falha'));

      expect(result.isLeft(), true);
      result.fold(
        (f) {
          expect(f, isA<DatabaseFailure>());
          expect(f.message, contains('add failed'));
          expect(f.stackTrace, isNotNull);
        },
        (_) => fail('expected Left'),
      );
    });
  });

  group('updateRecipe', () {
    test('retorna Right com receita atualizada', () async {
      final recipe = Recipe(id: 'r1', title: 'Original');
      dataSource.recipes = [recipe];

      recipe.title = 'Atualizado';
      final result = await repository.updateRecipe(recipe);

      expect(result.isRight(), true);
      result.fold((_) {}, (r) => expect(r.title, 'Atualizado'));
    });

    test('retorna Left quando data source falha', () async {
      dataSource.shouldThrow = true;
      final result = await repository.updateRecipe(Recipe(title: 'Falha'));

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<DatabaseFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('deleteRecipe', () {
    test('retorna Right e remove do data source', () async {
      final recipe = Recipe(id: 'del-1', title: 'Deletar');
      dataSource.recipes = [recipe];

      final result = await repository.deleteRecipe('del-1');

      expect(result.isRight(), true);
      expect(dataSource.recipes, isEmpty);
    });

    test('retorna Left quando data source falha', () async {
      dataSource.shouldThrow = true;
      final result = await repository.deleteRecipe('any');

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<DatabaseFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('getAllRecipes', () {
    test('retorna Right com lista de receitas', () async {
      dataSource.recipes = [
        Recipe(title: 'A'),
        Recipe(title: 'B'),
      ];

      final result = await repository.getAllRecipes();

      expect(result.isRight(), true);
      result.fold((_) {}, (list) => expect(list.length, 2));
    });

    test('retorna Right com lista vazia', () async {
      final result = await repository.getAllRecipes();

      expect(result.isRight(), true);
      result.fold((_) {}, (list) => expect(list, isEmpty));
    });

    test('retorna Left quando data source falha', () async {
      dataSource.shouldThrow = true;
      final result = await repository.getAllRecipes();

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<DatabaseFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });
}
