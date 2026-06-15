import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> addRecipe(Recipe recipe);
  Future<Either<Failure, Recipe>> updateRecipe(Recipe recipe);
  Future<Either<Failure, void>> deleteRecipe(String id);
  Future<Either<Failure, Recipe>> getRecipeById(String id);
  Future<Either<Failure, List<Recipe>>> getAllRecipes();
}
