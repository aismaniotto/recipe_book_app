import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class DeleteRecipe {
  final RecipeRepository repostitory;

  DeleteRecipe({required this.repostitory});

  Future<Either<Failure, void>> call(Recipe recipe) async {
    return await repostitory.deleteRecipe(recipe.id);
  }
}
