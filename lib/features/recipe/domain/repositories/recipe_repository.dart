import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Recipe> addRecipe(Recipe recipe);
  Future<Recipe> updateRecipe(Recipe recipe);
  Future<void> deleteRecipe(int id);
  Future<Recipe> getRecipeById(int id);
  Future<List<Recipe>> getAllRecipes();
}
