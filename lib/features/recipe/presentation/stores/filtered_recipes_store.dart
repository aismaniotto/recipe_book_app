import 'package:mobx/mobx.dart';
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
    await _updateRecipe(recipe);
    await getAllRecipes();
  }

  @action
  Future getAllRecipes() async {
    _recipes = await _getAllRecipes();
  }

  @action
  Future deleteRecipe(Recipe recipe) async {
    await _deleteRecipe(recipe);
  }
}
