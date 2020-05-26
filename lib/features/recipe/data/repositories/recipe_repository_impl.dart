import 'package:recipe_book_app/features/recipe/data/datasources/recipe_source.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeDataSource recipeDataSource;

  RecipeRepositoryImpl(this.recipeDataSource);

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    return await recipeDataSource.addRecipe(recipe);
  }

  @override
  Future<void> deleteRecipe(int id) async {
    await recipeDataSource.deleteRecipe(id);
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    return await recipeDataSource.updateRecipe(recipe);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    var allRecipes = await recipeDataSource.getAllRecipes();
    if (allRecipes == null){
      allRecipes = List<Recipe>();
    }

    return allRecipes;
  }

  @override
  Future<Recipe> getRecipeById(int id) async {
    return await recipeDataSource.getRecipeById(id);
  }
}
