import 'package:recipe_book_app/features/recipe/data/datasources/recipe_source.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class FakeRecipeDataSource implements RecipeDataSource {
  List<Recipe> recipes = [];
  bool shouldThrow = false;

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    if (shouldThrow) throw Exception('add failed');
    recipes.add(recipe);
    return recipe;
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    if (shouldThrow) throw Exception('update failed');
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) recipes[index] = recipe;
    return recipe;
  }

  @override
  Future<void> deleteRecipe(String id) async {
    if (shouldThrow) throw Exception('delete failed');
    recipes.removeWhere((r) => r.id == id);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    if (shouldThrow) throw Exception('getAll failed');
    return List.from(recipes);
  }
}
