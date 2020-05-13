import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class GetAllRecipes {
  final RecipeRepository repostitory;

  GetAllRecipes(this.repostitory);

  Future<List<Recipe>> call() async { 
    //TODO: maybe, order by name;
    return await this.repostitory.getAllRecipes();
  }
}
