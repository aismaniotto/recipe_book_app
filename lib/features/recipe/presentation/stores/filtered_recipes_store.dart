import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/core/services/crashlytics_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';

part 'filtered_recipes_store.g.dart';

enum SortOption { name, type, difficulty }

class FilteredRecipesStore extends _FilteredRecipesStore
    with _$FilteredRecipesStore {
  FilteredRecipesStore(super.getAllRecipes, super.deleteRecipe, super.updateRecipe);
}

abstract class _FilteredRecipesStore with Store {
  final GetAllRecipes _getAllRecipes;
  final DeleteRecipe _deleteRecipe;
  final UpdateRecipe _updateRecipe;

  @observable
  List<Recipe> _recipes = List.empty();

  @observable
  String searchQuery = '';

  @observable
  bool showFavoritesOnly = false;

  @observable
  SortOption sortOption = SortOption.name;

  @observable
  Failure? lastFailure;

  _FilteredRecipesStore(this._getAllRecipes, this._deleteRecipe, this._updateRecipe);

  @computed
  ObservableList<Recipe> get filteredRecipes {
    var result = _recipes.where((recipe) {
      if (showFavoritesOnly && !recipe.isFavorite) return false;
      if (searchQuery.isEmpty) return true;
      final query = searchQuery.toLowerCase();
      return recipe.title.toLowerCase().contains(query) ||
          (recipe.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    result.sort((a, b) {
      switch (sortOption) {
        case SortOption.name:
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        case SortOption.type:
          return a.type.index.compareTo(b.type.index);
        case SortOption.difficulty:
          return a.difficulty.index.compareTo(b.difficulty.index);
      }
    });

    return result.asObservable();
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void toggleFavoritesOnly() {
    showFavoritesOnly = !showFavoritesOnly;
  }

  @action
  void setSortOption(SortOption option) {
    sortOption = option;
  }

  @action
  Future toggleFavorite(Recipe recipe) async {
    recipe.isFavorite = !recipe.isFavorite;
    final result = await _updateRecipe(recipe);
    result.fold(
      (failure) => CrashlyticsService.recordFailure(failure),
      (_) {},
    );
    await getAllRecipes();
  }

  @action
  Future getAllRecipes() async {
    final result = await _getAllRecipes();
    result.fold(
      (failure) {
        lastFailure = failure;
        CrashlyticsService.recordFailure(failure);
      },
      (recipes) {
        lastFailure = null;
        _recipes = recipes;
      },
    );
  }

  @action
  Future deleteRecipe(Recipe recipe) async {
    final result = await _deleteRecipe(recipe);
    result.fold(
      (failure) => CrashlyticsService.recordFailure(failure),
      (_) {},
    );
  }
}
