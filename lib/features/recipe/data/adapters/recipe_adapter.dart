import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/ingredient_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeAdapter extends Adapter<Recipe> {
  final IngredientAdapter ingredientAdapter;

  RecipeAdapter(this.ingredientAdapter);

  @override
  Recipe fromMap(Map<String, dynamic> map) {
    Recipe recipe = Recipe(
      map['name'], 
      map['description'], 
      map['type'],
      map['quantityPeopleServide'], 
      (map['ingredientList'] as List).map((map) => ingredientAdapter.fromMap(map)), 
      map['steps']);
    
    recipe.id = map['id'];
    
    return recipe;
  }

  @override
  Map<String, dynamic> toMap(Recipe recipe){
    return {
      'id': recipe.id,
      'name': recipe.name,
      'description': recipe.description,
      'type': recipe.type,
      'quantityPeopleServide': recipe.quantityPeopleServide,
      'ingredientList': recipe.ingredientList.map((ingredient) => ingredientAdapter.toMap(ingredient)),
      'steps': recipe.steps
    };
  }
}
