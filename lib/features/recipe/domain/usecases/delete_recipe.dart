import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class DeleteRecipe {
  final RecipeRepository repostitory;

  DeleteRecipe(this.repostitory);

  Future call(Recipe recipe) async {
    return await this.repostitory.deleteRecipe(recipe.id);
  }
}
