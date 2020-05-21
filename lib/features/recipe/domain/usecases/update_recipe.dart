import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class UpdateRecipe {
  final RecipeRepository repostitory;

  UpdateRecipe(this.repostitory);

  Future<Recipe> call(Recipe recipe) async {
    return await this.repostitory.updateRecipe(recipe);
  }
}
