import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class AddRecipe {
  final RecipeRepository repostitory;

  AddRecipe({required this.repostitory});

  Future<Recipe> call(Recipe recipe) async {
    // TODO: check if already exist
    return await this.repostitory.addRecipe(recipe);
  }
}
