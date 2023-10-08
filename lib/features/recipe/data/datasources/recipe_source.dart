import 'dart:async';

import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/data/datasources/app_database.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:sembast/sembast.dart';

abstract class RecipeDataSource {
  Future<Recipe> addRecipe(Recipe recipe);
  Future<Recipe> updateRecipe(Recipe recipe);
  Future<void> deleteRecipe(String id);
  Future<Recipe> getRecipeById(String id);
  Future<List<Recipe>> getAllRecipes();
}

class RecipeDataSourceImpl extends RecipeDataSource {
  static const String folderName = "Recipes";
  final _recipesFolder = stringMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  final RecipeAdapter recipeAdapter;

  RecipeDataSourceImpl({required this.recipeAdapter});

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    await _recipesFolder.add(await _db, recipeAdapter.toMap(recipe));
    return recipe;
  }

  @override
  Future<void> deleteRecipe(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    await _recipesFolder.delete(await _db, finder: finder);
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    final finder = Finder(filter: Filter.equals('id', recipe.id));
    await _recipesFolder.update(await _db, recipeAdapter.toMap(recipe),
        finder: finder);

    return recipe;
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final recordsSnapshot = await _recipesFolder.find(await _db);
    return recordsSnapshot.map((snapshot) {
      return recipeAdapter.fromMap(snapshot.value);
    }).toList();
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    final recipe = await (_recipesFolder.record(id).get(await _db)
        as FutureOr<Map<String, Object?>>);
    return recipeAdapter.fromMap(recipe);
  }
}
