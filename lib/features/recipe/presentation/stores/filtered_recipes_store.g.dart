// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_recipes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilteredRecipesStore on _FilteredRecipesStore, Store {
  Computed<ObservableList<Recipe>>? _$filteredRecipesComputed;

  @override
  ObservableList<Recipe> get filteredRecipes =>
      (_$filteredRecipesComputed ??= Computed<ObservableList<Recipe>>(
        () => super.filteredRecipes,
        name: '_FilteredRecipesStore.filteredRecipes',
      )).value;

  late final _$_recipesAtom = Atom(
    name: '_FilteredRecipesStore._recipes',
    context: context,
  );

  @override
  List<Recipe> get _recipes {
    _$_recipesAtom.reportRead();
    return super._recipes;
  }

  @override
  set _recipes(List<Recipe> value) {
    _$_recipesAtom.reportWrite(value, super._recipes, () {
      super._recipes = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_FilteredRecipesStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$showFavoritesOnlyAtom = Atom(
    name: '_FilteredRecipesStore.showFavoritesOnly',
    context: context,
  );

  @override
  bool get showFavoritesOnly {
    _$showFavoritesOnlyAtom.reportRead();
    return super.showFavoritesOnly;
  }

  @override
  set showFavoritesOnly(bool value) {
    _$showFavoritesOnlyAtom.reportWrite(value, super.showFavoritesOnly, () {
      super.showFavoritesOnly = value;
    });
  }

  late final _$sortOptionAtom = Atom(
    name: '_FilteredRecipesStore.sortOption',
    context: context,
  );

  @override
  SortOption get sortOption {
    _$sortOptionAtom.reportRead();
    return super.sortOption;
  }

  @override
  set sortOption(SortOption value) {
    _$sortOptionAtom.reportWrite(value, super.sortOption, () {
      super.sortOption = value;
    });
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    '_FilteredRecipesStore.toggleFavorite',
    context: context,
  );

  @override
  Future<dynamic> toggleFavorite(Recipe recipe) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(recipe));
  }

  late final _$getAllRecipesAsyncAction = AsyncAction(
    '_FilteredRecipesStore.getAllRecipes',
    context: context,
  );

  @override
  Future<dynamic> getAllRecipes() {
    return _$getAllRecipesAsyncAction.run(() => super.getAllRecipes());
  }

  late final _$deleteRecipeAsyncAction = AsyncAction(
    '_FilteredRecipesStore.deleteRecipe',
    context: context,
  );

  @override
  Future<dynamic> deleteRecipe(Recipe recipe) {
    return _$deleteRecipeAsyncAction.run(() => super.deleteRecipe(recipe));
  }

  late final _$_FilteredRecipesStoreActionController = ActionController(
    name: '_FilteredRecipesStore',
    context: context,
  );

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_FilteredRecipesStoreActionController.startAction(
      name: '_FilteredRecipesStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_FilteredRecipesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFavoritesOnly() {
    final _$actionInfo = _$_FilteredRecipesStoreActionController.startAction(
      name: '_FilteredRecipesStore.toggleFavoritesOnly',
    );
    try {
      return super.toggleFavoritesOnly();
    } finally {
      _$_FilteredRecipesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortOption(SortOption option) {
    final _$actionInfo = _$_FilteredRecipesStoreActionController.startAction(
      name: '_FilteredRecipesStore.setSortOption',
    );
    try {
      return super.setSortOption(option);
    } finally {
      _$_FilteredRecipesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
showFavoritesOnly: ${showFavoritesOnly},
sortOption: ${sortOption},
filteredRecipes: ${filteredRecipes}
    ''';
  }
}
