import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class EnumToString {
  static String DifficultyToString(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return 'Easy';
        break;
      case Difficulty.medium:
        return 'Medium';
        break;
      case Difficulty.hard:
        return 'Hard';
        break;
      default:
        return 'Unknow';
    }
  }

  static String RecipeTypeToString(Type type) {
    switch (type) {
      case Type.breakfast:
        return 'Breakfast';
        break;
      case Type.meal:
        return 'Meal';
        break;
      case Type.side:
        return 'Side';
        break;
      case Type.snack:
        return 'Snack';
        break;
      case Type.drink:
        return 'Drink';
        break;
      case Type.dessert:
        return 'Dessert';
        break;
      case Type.other:
        return 'Other';
        break;

      default:
        return 'Other';
    }
  }
}
