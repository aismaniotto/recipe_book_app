import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

class AddRecipe {
  final RecipeRepository repostitory;

  AddRecipe(this.repostitory);

  Future<Recipe> call(
      {@required String title,
      @required String description,
      @required Type type,
      @required int quantityPeopleServide,
      @required Difficulty difficulty,
      @required List<IdentificableText> ingredientList,
      @required List<IdentificableText> steps}) async {
    // TODO: check if already exist
    return await this.repostitory.addRecipe(Recipe(
        id: Uuid().v4(),
        title: title,
        description: description,
        type: type,
        quantityPeopleServide: quantityPeopleServide,
        difficulty: difficulty,
        ingredientList: ingredientList,
        steps: steps));
  }
}
