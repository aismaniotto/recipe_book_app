import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Recipe> addRecipe(Recipe recipe);
  Future<Recipe> updateRecipe(Recipe recipe);
  Future<void> deleteRecipe(String id);
  Future<Recipe> getRecipeById(String id);
  Future<List<Recipe>> getAllRecipes();
}
