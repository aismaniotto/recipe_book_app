import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipe {
  final RecipeRepository repostitory;

  GetRecipe({required this.repostitory});

  Future<Recipe> call(String id) async {
    return await this.repostitory.getRecipeById(id);
  }
}
