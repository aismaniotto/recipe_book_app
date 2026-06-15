import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class GetAllRecipes {
  final RecipeRepository repository;

  GetAllRecipes({required this.repository});

  Future<Either<Failure, List<Recipe>>> call() async {
    return await repository.getAllRecipes();
  }
}
