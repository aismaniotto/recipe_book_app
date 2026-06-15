import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class FakeRecipeRepository implements RecipeRepository {
  List<Recipe> recipes = [];
  Recipe? lastSaved;
  String? lastDeletedId;
  int addCallCount = 0;
  int updateCallCount = 0;
  int deleteCallCount = 0;
  int getAllCallCount = 0;
  int getByIdCallCount = 0;

  @override
  Future<Recipe> addRecipe(Recipe recipe) async {
    addCallCount++;
    lastSaved = recipe;
    recipes.add(recipe);
    return recipe;
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    updateCallCount++;
    lastSaved = recipe;
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) recipes[index] = recipe;
    return recipe;
  }

  @override
  Future<void> deleteRecipe(String id) async {
    deleteCallCount++;
    lastDeletedId = id;
    recipes.removeWhere((r) => r.id == id);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    getAllCallCount++;
    return List.from(recipes);
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    getByIdCallCount++;
    return recipes.firstWhere((r) => r.id == id);
  }
}
