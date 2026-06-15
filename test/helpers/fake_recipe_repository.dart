import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class FakeRecipeRepository implements RecipeRepository {
  List<Recipe> recipes = [];
  Recipe? lastSaved;
  String? lastDeletedId;
  int addCallCount = 0;
  int updateCallCount = 0;
  int deleteCallCount = 0;
  int getAllCallCount = 0;
  bool shouldFail = false;

  @override
  Future<Either<Failure, Recipe>> addRecipe(Recipe recipe) async {
    addCallCount++;
    if (shouldFail) return Left(DatabaseFailure(message: 'add failed'));
    lastSaved = recipe;
    recipes.add(recipe);
    return Right(recipe);
  }

  @override
  Future<Either<Failure, Recipe>> updateRecipe(Recipe recipe) async {
    updateCallCount++;
    if (shouldFail) return Left(DatabaseFailure(message: 'update failed'));
    lastSaved = recipe;
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) recipes[index] = recipe;
    return Right(recipe);
  }

  @override
  Future<Either<Failure, void>> deleteRecipe(String id) async {
    deleteCallCount++;
    if (shouldFail) return Left(DatabaseFailure(message: 'delete failed'));
    lastDeletedId = id;
    recipes.removeWhere((r) => r.id == id);
    return Right(null);
  }

  @override
  Future<Either<Failure, List<Recipe>>> getAllRecipes() async {
    getAllCallCount++;
    if (shouldFail) return Left(DatabaseFailure(message: 'getAll failed'));
    return Right(List.from(recipes));
  }

}
