import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class AddRecipe {
  final RecipeRepository repostitory;

  AddRecipe(this.repostitory);

  Future<Recipe> call(Recipe recipe) async {
    // TODO: check if already exist
    // TODO: check if name alredy been used
    return await this.repostitory.addRecipe(recipe);
  }
}
