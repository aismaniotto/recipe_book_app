import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/ingredient_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:sembast/utils/value_utils.dart';

class RecipeAdapter extends Adapter<Recipe> {
  final IngredientAdapter ingredientAdapter;

  RecipeAdapter(this.ingredientAdapter);

  @override
  Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      map['id'], 
      map['name'], 
      map['description'], 
      (map['ingredientList'] as List).map((ingredientMap) => ingredientAdapter.fromMap(ingredientMap)).toList(), 
      map['steps'].cast<String>());
  }

  @override
  Map<String, dynamic> toMap(Recipe recipe){
    return {
      'id': recipe.id,
      'name': recipe.name,
      'description': recipe.description,
      'ingredientList': recipe.ingredientList.map((ingredient) => ingredientAdapter.toMap(ingredient)).toList(),
      'steps': recipe.steps
    };
  }
}
