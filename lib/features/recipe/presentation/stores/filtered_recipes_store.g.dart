// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_recipes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilteredRecipesStore on _FilteredRecipesStore, Store {
  Computed<ObservableList<Recipe>>? _$filteredRecipesComputed;

  @override
  ObservableList<Recipe> get filteredRecipes => (_$filteredRecipesComputed ??=
          Computed<ObservableList<Recipe>>(() => super.filteredRecipes,
              name: '_FilteredRecipesStore.filteredRecipes'))
      .value;

  late final _$_recipesAtom =
      Atom(name: '_FilteredRecipesStore._recipes', context: context);

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

  late final _$filterAtom =
      Atom(name: '_FilteredRecipesStore.filter', context: context);

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$getAllRecipesAsyncAction =
      AsyncAction('_FilteredRecipesStore.getAllRecipes', context: context);

  @override
  Future<dynamic> getAllRecipes() {
    return _$getAllRecipesAsyncAction.run(() => super.getAllRecipes());
  }

  late final _$deleteRecipeAsyncAction =
      AsyncAction('_FilteredRecipesStore.deleteRecipe', context: context);

  @override
  Future<dynamic> deleteRecipe(Recipe recipe) {
    return _$deleteRecipeAsyncAction.run(() => super.deleteRecipe(recipe));
  }

  @override
  String toString() {
    return '''
filter: ${filter},
filteredRecipes: ${filteredRecipes}
    ''';
  }
}
