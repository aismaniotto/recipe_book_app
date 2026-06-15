import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/identificable_text_adapater.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeAdapter extends Adapter<Recipe> {
  final IdentificableTextAdapter identificableTextAdapter;

  RecipeAdapter(this.identificableTextAdapter);

  @override
  Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        type: Type.values.firstWhere(
            (e) => e.toString() == map['type'],
            orElse: () => Type.other),
        quantityPeopleServide: map['quantityPeopleServide'],
        difficulty: Difficulty.values.firstWhere(
            (e) => e.toString() == map['difficulty'],
            orElse: () => Difficulty.easy),
        ingredientList: (map['ingredientList'] as List)
            .map((ingredientMap) =>
                identificableTextAdapter.fromMap(ingredientMap))
            .toList(),
        steps: (map['steps'] as List)
            .map((stepMap) => identificableTextAdapter.fromMap(stepMap))
            .toList(),
        isFavorite: map['isFavorite'] as bool?,
        prepTimeMinutes: map['prepTimeMinutes'] as int?);
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
          .map((ingredient) => identificableTextAdapter.toMap(ingredient))
          .toList(),
      'steps': recipe.steps
          .map((step) => identificableTextAdapter.toMap(step))
          .toList(),
      'isFavorite': recipe.isFavorite,
      'prepTimeMinutes': recipe.prepTimeMinutes,
    };
  }
}
