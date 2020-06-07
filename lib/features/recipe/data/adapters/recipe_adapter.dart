import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/ingredient_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeAdapter extends Adapter<Recipe> {
  final IngredientAdapter ingredientAdapter;

  RecipeAdapter(this.ingredientAdapter);

  @override
  Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        type: Type.values.firstWhere((e) => e.toString() == map['type']),
        quantityPeopleServide: map['quantityPeopleServide'],
        difficulty: Difficulty.values
            .firstWhere((e) => e.toString() == map['difficulty']),
        ingredientList: (map['ingredientList'] as List)
            .map((ingredientMap) => ingredientAdapter.fromMap(ingredientMap))
            .toList(),
        steps: map['steps'].cast<String>());
  }

  @override
  Map<String, dynamic> toMap(Recipe recipe) {
    return {
      'id': recipe.id,
      'title': recipe.title,
      'description': recipe.description,
      'type': recipe.type.toString(),
      'quantityPeopleServide': recipe.quantityPeopleServide,
      'difficulty': recipe.difficulty.toString(),
      'ingredientList': recipe.ingredientList
          .map((ingredient) => ingredientAdapter.toMap(ingredient))
          .toList(),
      'steps': recipe.steps
    };
  }
}
