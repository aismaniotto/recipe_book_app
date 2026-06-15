import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class DeleteAllRecipes {
  final RecipeRepository repository;

  DeleteAllRecipes({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.deleteAll();
  }
}
