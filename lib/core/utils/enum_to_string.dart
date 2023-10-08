import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class EnumToString {
  static String difficultyToString(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return LocaleKeys.difficulty_easy.tr();
      case Difficulty.medium:
        return LocaleKeys.difficulty_medium.tr();
      case Difficulty.hard:
        return LocaleKeys.difficulty_hard.tr();
      default:
        return LocaleKeys.unknow.tr();
    }
  }

  static String recipeTypeToString(Type type) {
    switch (type) {
      case Type.breakfast:
        return LocaleKeys.recipe_type_breakfast.tr();
      case Type.meal:
        return LocaleKeys.recipe_type_meal.tr();
      case Type.side:
        return LocaleKeys.recipe_type_side.tr();
      case Type.snack:
        return LocaleKeys.recipe_type_snack.tr();
      case Type.drink:
        return LocaleKeys.recipe_type_drink.tr();
      case Type.dessert:
        return LocaleKeys.recipe_type_dessert.tr();
      case Type.other:
        return LocaleKeys.recipe_type_some_other.tr();

      default:
        return LocaleKeys.recipe_type_some_other.tr();
    }
  }
}
