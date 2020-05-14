import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/data/datasources/app_database.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:sembast/sembast.dart';

abstract class RecipeDataSource {
  Future<Recipe> addRecipe(Recipe recipe);
  Future<Recipe> editRecipe(Recipe recipe);
  Future<void> deleteRecipe(int id);
  Future<Recipe> getRecipeById(int id);
  Future<List<Recipe>> getAllRecipes();
}

class RecipeDataSourceImpl extends RecipeDataSource {
  static const String folderName = "Recipes";
  final _recipesFolder = intMapStoreFactory.store(folderName);

  Future<Database> get  _db  async => await AppDatabase.instance.database;
  
  final RecipeAdapter recipeAdapter;

  RecipeDataSourceImpl(this.recipeAdapter);

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    await  _recipesFolder.add(await _db, recipeAdapter.toMap(recipe));
    return recipe;
  }

  @override
  Future<void> deleteRecipe(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _recipesFolder.delete(await _db, finder: finder);
  }

  @override
  Future<Recipe> editRecipe(Recipe recipe) async {
    final finder = Finder(filter: Filter.byKey(recipe.id));
    await _recipesFolder.update(await _db, recipeAdapter.toMap(recipe),finder: finder);
    
    return recipe;
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final recordsSnapshot = await _recipesFolder.find(await _db);
    return recordsSnapshot.map((snapshot){
      return recipeAdapter.fromMap(snapshot.value);
    }).toList();
  }

  @override
  Future<Recipe> getRecipeById(int id) async {
    final recipe = await _recipesFolder.record(id).get(await _db);
    return recipeAdapter.fromMap(recipe);
  }
}
