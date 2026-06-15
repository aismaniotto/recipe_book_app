import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:recipe_book_app/core/error/failure.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';

class ExportRecipes {
  final RecipeRepository repository;
  final RecipeAdapter adapter;

  ExportRecipes({required this.repository, required this.adapter});

  Future<Either<Failure, String>> call() async {
    final result = await repository.getAllRecipes();
    return result.fold(
      (failure) => Left(failure),
      (recipes) {
        final list = recipes.map((r) => adapter.toMap(r)).toList();
        return Right(jsonEncode(list));
      },
    );
  }
}
