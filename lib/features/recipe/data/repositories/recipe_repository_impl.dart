import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/data/datasources/recipe_source.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeDataSource recipeDataSource;

  RecipeRepositoryImpl({required this.recipeDataSource});

  @override
  Future<Either<Failure, Recipe>> addRecipe(Recipe recipe) async {
    try {
      final result = await recipeDataSource.addRecipe(recipe);
      return Right(result);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipe(String id) async {
    try {
      await recipeDataSource.deleteRecipe(id);
      return Right(null);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }

  @override
  Future<Either<Failure, Recipe>> updateRecipe(Recipe recipe) async {
    try {
      final result = await recipeDataSource.updateRecipe(recipe);
      return Right(result);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAll() async {
    try {
      await recipeDataSource.deleteAll();
      return Right(null);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getAllRecipes() async {
    try {
      final result = await recipeDataSource.getAllRecipes();
      return Right(result);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }

}
