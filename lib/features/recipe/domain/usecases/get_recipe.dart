import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipe {
  final RecipeRepository repostitory;

  GetRecipe({required this.repostitory});

  Future<Either<Failure, Recipe>> call(String id) async {
    return await repostitory.getRecipeById(id);
  }
}
