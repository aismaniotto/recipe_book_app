import 'package:recipe_book_app/features/recipe/data/datasources/recipe_source.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeDataSource recipeDataSource;

  RecipeRepositoryImpl({required this.recipeDataSource});

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    return await recipeDataSource.addRecipe(recipe);
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await recipeDataSource.deleteRecipe(id);
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    return await recipeDataSource.updateRecipe(recipe);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    return await recipeDataSource.getAllRecipes();
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    return await recipeDataSource.getRecipeById(id);
  }
}
