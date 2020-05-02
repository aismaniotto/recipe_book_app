import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Recipe addRecipe(Recipe recipe);
  Recipe editRecipe(Recipe recipe);
  void deleteRecipe(String id);
  Recipe getRecipeById(String id);
  List<Recipe> getAllRecipes();
}
