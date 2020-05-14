import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';

class IngredientAdapter extends Adapter<Ingredient> {
  @override
  Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(map['name'], map['quantity'], map['measure']);
  }

  @override
  Map<String, dynamic> toMap(Ingredient ingredient) {
    return {
      'name': ingredient.name,
      'quantity': ingredient.quantity,
      'measure': ingredient.measure
    };
  }
}
