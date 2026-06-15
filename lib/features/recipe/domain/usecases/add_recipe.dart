import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class AddRecipe {
  final RecipeRepository repostitory;

  AddRecipe({required this.repostitory});

  Future<Either<Failure, Recipe>> call(Recipe recipe) async {
    return await repostitory.addRecipe(recipe);
  }
}
