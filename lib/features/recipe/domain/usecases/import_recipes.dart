import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class ImportRecipes {
  final RecipeRepository repository;
  final RecipeAdapter adapter;

  ImportRecipes({required this.repository, required this.adapter});

  Future<Either<Failure, int>> call(String jsonString) async {
    try {
      final list = jsonDecode(jsonString) as List;
      int count = 0;
      for (final item in list) {
        final recipe = adapter.fromMap(item as Map<String, dynamic>);
        final result = await repository.addRecipe(recipe);
        if (result.isRight()) count++;
      }
      return Right(count);
    } catch (e, s) {
      return Left(DatabaseFailure.fromError(e, s));
    }
  }
}
