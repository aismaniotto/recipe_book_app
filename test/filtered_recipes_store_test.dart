import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';

import 'helpers/fake_recipe_repository.dart';

void main() {
  late FilteredRecipesStore store;
  late FakeRecipeRepository repository;

  setUp(() {
    repository = FakeRecipeRepository();
    store = FilteredRecipesStore(
      GetAllRecipes(repostitory: repository),
      DeleteRecipe(repostitory: repository),
      UpdateRecipe(repostitory: repository),
    );
  });

  Recipe makeRecipe({
    String title = '',
    String? description,
    Type type = Type.other,
    Difficulty difficulty = Difficulty.easy,
    bool isFavorite = false,
    int? prepTimeMinutes,
  }) {
    return Recipe(
      title: title,
      description: description,
      type: type,
      difficulty: difficulty,
      isFavorite: isFavorite,
      prepTimeMinutes: prepTimeMinutes,
    );
  }

  group('getAllRecipes', () {
    test('carrega receitas do repositório', () async {
      repository.recipes = [
        makeRecipe(title: 'Bolo'),
        makeRecipe(title: 'Sopa'),
      ];

      await store.getAllRecipes();

      expect(store.filteredRecipes.length, 2);
    });

    test('retorna lista vazia quando não há receitas', () async {
      await store.getAllRecipes();
      expect(store.filteredRecipes, isEmpty);
    });
  });

  group('busca', () {
    setUp(() async {
      repository.recipes = [
        makeRecipe(title: 'Bolo de chocolate', description: 'Delicioso'),
        makeRecipe(title: 'Sopa de legumes', description: 'Nutritiva'),
        makeRecipe(title: 'Cookies', description: 'Crocantes'),
      ];
      await store.getAllRecipes();
    });

    test('filtra por título', () {
      store.setSearchQuery('bolo');
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Bolo de chocolate');
    });

    test('filtra por descrição', () {
      store.setSearchQuery('crocantes');
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Cookies');
    });

    test('busca é case insensitive', () {
      store.setSearchQuery('SOPA');
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Sopa de legumes');
    });

    test('retorna vazio quando nenhuma receita corresponde', () {
      store.setSearchQuery('pizza');
      expect(store.filteredRecipes, isEmpty);
    });

    test('retorna todas quando busca está vazia', () {
      store.setSearchQuery('bolo');
      expect(store.filteredRecipes.length, 1);
      store.setSearchQuery('');
      expect(store.filteredRecipes.length, 3);
    });

    test('busca parcial encontra resultados', () {
      store.setSearchQuery('bol');
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Bolo de chocolate');
    });

    test('busca com acentos funciona', () async {
      repository.recipes = [
        makeRecipe(title: 'Pão de queijo'),
        makeRecipe(title: 'Café'),
      ];
      await store.getAllRecipes();

      store.setSearchQuery('pão');
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Pão de queijo');
    });

    test('busca com receita sem descrição não quebra', () async {
      repository.recipes = [
        makeRecipe(title: 'Sem descrição', description: null),
      ];
      await store.getAllRecipes();

      store.setSearchQuery('algo');
      expect(store.filteredRecipes, isEmpty);
    });
  });

  group('favoritos', () {
    setUp(() async {
      repository.recipes = [
        makeRecipe(title: 'Bolo', isFavorite: true),
        makeRecipe(title: 'Sopa', isFavorite: false),
        makeRecipe(title: 'Cookies', isFavorite: true),
      ];
      await store.getAllRecipes();
    });

    test('mostra todas por padrão', () {
      expect(store.showFavoritesOnly, false);
      expect(store.filteredRecipes.length, 3);
    });

    test('filtra apenas favoritas', () {
      store.toggleFavoritesOnly();
      expect(store.showFavoritesOnly, true);
      expect(store.filteredRecipes.length, 2);
      expect(
        store.filteredRecipes.every((r) => r.isFavorite),
        true,
      );
    });

    test('toggle duplo volta a mostrar todas', () {
      store.toggleFavoritesOnly();
      store.toggleFavoritesOnly();
      expect(store.showFavoritesOnly, false);
      expect(store.filteredRecipes.length, 3);
    });

    test('toggleFavorite alterna o estado da receita', () async {
      final recipe = store.filteredRecipes
          .firstWhere((r) => r.title == 'Sopa');
      expect(recipe.isFavorite, false);

      await store.toggleFavorite(recipe);

      final updated = store.filteredRecipes
          .firstWhere((r) => r.title == 'Sopa');
      expect(updated.isFavorite, true);
    });

    test('toggleFavorite duplo volta ao estado original', () async {
      final recipe = store.filteredRecipes
          .firstWhere((r) => r.title == 'Sopa');

      await store.toggleFavorite(recipe);
      final afterFirst = store.filteredRecipes
          .firstWhere((r) => r.title == 'Sopa');
      expect(afterFirst.isFavorite, true);

      await store.toggleFavorite(afterFirst);
      final afterSecond = store.filteredRecipes
          .firstWhere((r) => r.title == 'Sopa');
      expect(afterSecond.isFavorite, false);
    });

    test('filtro favoritos com nenhuma favorita retorna vazio', () async {
      repository.recipes = [
        makeRecipe(title: 'A', isFavorite: false),
        makeRecipe(title: 'B', isFavorite: false),
      ];
      await store.getAllRecipes();

      store.toggleFavoritesOnly();
      expect(store.filteredRecipes, isEmpty);
    });
  });

  group('ordenação', () {
    setUp(() async {
      repository.recipes = [
        makeRecipe(
            title: 'Cookies', type: Type.snack, difficulty: Difficulty.easy),
        makeRecipe(
            title: 'Arroz', type: Type.meal, difficulty: Difficulty.hard),
        makeRecipe(
            title: 'Bolo', type: Type.dessert, difficulty: Difficulty.medium),
      ];
      await store.getAllRecipes();
    });

    test('ordena por nome por padrão', () {
      expect(store.sortOption, SortOption.name);
      expect(store.filteredRecipes[0].title, 'Arroz');
      expect(store.filteredRecipes[1].title, 'Bolo');
      expect(store.filteredRecipes[2].title, 'Cookies');
    });

    test('ordena por tipo', () {
      store.setSortOption(SortOption.type);
      expect(store.filteredRecipes[0].type, Type.meal);
      expect(store.filteredRecipes[1].type, Type.snack);
      expect(store.filteredRecipes[2].type, Type.dessert);
    });

    test('ordena por dificuldade', () {
      store.setSortOption(SortOption.difficulty);
      expect(store.filteredRecipes[0].difficulty, Difficulty.easy);
      expect(store.filteredRecipes[1].difficulty, Difficulty.medium);
      expect(store.filteredRecipes[2].difficulty, Difficulty.hard);
    });

    test('ordenação por nome é case insensitive', () async {
      repository.recipes = [
        makeRecipe(title: 'banana'),
        makeRecipe(title: 'Abacaxi'),
      ];
      await store.getAllRecipes();

      expect(store.filteredRecipes[0].title, 'Abacaxi');
      expect(store.filteredRecipes[1].title, 'banana');
    });
  });

  group('combinações', () {
    setUp(() async {
      repository.recipes = [
        makeRecipe(title: 'Bolo de chocolate', isFavorite: true,
            type: Type.dessert, difficulty: Difficulty.medium),
        makeRecipe(title: 'Bolo de cenoura', isFavorite: false,
            type: Type.dessert, difficulty: Difficulty.easy),
        makeRecipe(title: 'Sopa', isFavorite: true,
            type: Type.meal, difficulty: Difficulty.easy),
        makeRecipe(title: 'Arroz', isFavorite: false,
            type: Type.meal, difficulty: Difficulty.easy),
      ];
      await store.getAllRecipes();
    });

    test('busca + favoritos', () {
      store.setSearchQuery('bolo');
      store.toggleFavoritesOnly();
      expect(store.filteredRecipes.length, 1);
      expect(store.filteredRecipes[0].title, 'Bolo de chocolate');
    });

    test('ordenação + busca mantém ordem', () {
      store.setSortOption(SortOption.difficulty);
      store.setSearchQuery('bolo');

      expect(store.filteredRecipes.length, 2);
      expect(store.filteredRecipes[0].title, 'Bolo de cenoura'); // easy
      expect(store.filteredRecipes[1].title, 'Bolo de chocolate'); // medium
    });

    test('ordenação + favoritos', () {
      store.toggleFavoritesOnly();
      store.setSortOption(SortOption.type);

      expect(store.filteredRecipes.length, 2);
      // meal(1) before dessert(5)
      expect(store.filteredRecipes[0].title, 'Sopa');
      expect(store.filteredRecipes[1].title, 'Bolo de chocolate');
    });

    test('busca + favoritos + ordenação', () async {
      repository.recipes.add(makeRecipe(
          title: 'Bolo de fubá', isFavorite: true,
          type: Type.dessert, difficulty: Difficulty.hard));
      await store.getAllRecipes();

      store.setSearchQuery('bolo');
      store.toggleFavoritesOnly();
      store.setSortOption(SortOption.difficulty);

      expect(store.filteredRecipes.length, 2);
      expect(store.filteredRecipes[0].title, 'Bolo de chocolate'); // medium
      expect(store.filteredRecipes[1].title, 'Bolo de fubá'); // hard
    });
  });

  group('deleteRecipe', () {
    test('remove receita do repositório', () async {
      final recipe = makeRecipe(title: 'Para deletar');
      repository.recipes = [recipe];
      await store.getAllRecipes();
      expect(store.filteredRecipes.length, 1);

      await store.deleteRecipe(recipe);
      await store.getAllRecipes();
      expect(store.filteredRecipes, isEmpty);
    });
  });

  group('lastFailure', () {
    test('é null quando getAllRecipes sucede', () async {
      repository.recipes = [makeRecipe(title: 'Ok')];
      await store.getAllRecipes();

      expect(store.lastFailure, isNull);
    });

    test('é preenchido quando getAllRecipes falha', () async {
      repository.shouldFail = true;
      await store.getAllRecipes();

      expect(store.lastFailure, isNotNull);
      expect(store.lastFailure!.message, 'getAll failed');
    });

    test('é limpo quando getAllRecipes sucede após falha', () async {
      repository.shouldFail = true;
      await store.getAllRecipes();
      expect(store.lastFailure, isNotNull);

      repository.shouldFail = false;
      repository.recipes = [makeRecipe(title: 'Ok')];
      await store.getAllRecipes();
      expect(store.lastFailure, isNull);
    });
  });
}
