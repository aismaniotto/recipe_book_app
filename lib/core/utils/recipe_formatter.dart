import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/utils/enum_to_string.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeFormatter {
  static String toShareText(Recipe recipe) {
    final buffer = StringBuffer();

    buffer.writeln(recipe.title.toUpperCase());
    buffer.writeln();

    buffer.writeln('${LocaleKeys.type.tr()}: ${EnumToString.recipeTypeToString(recipe.type)}');
    buffer.writeln('${LocaleKeys.difficulty_level.tr()}: ${EnumToString.difficultyToString(recipe.difficulty)}');

    if (recipe.quantityPeopleServide != null) {
      final label = recipe.quantityPeopleServide! > 1
          ? LocaleKeys.person_people.tr()
          : LocaleKeys.person_person.tr();
      buffer.writeln('${LocaleKeys.serve.tr()}: ${recipe.quantityPeopleServide} $label');
    }

    if (recipe.prepTimeMinutes != null) {
      buffer.writeln('${LocaleKeys.prep_time.tr()}: ${LocaleKeys.prep_time_minutes.tr(namedArgs: {'minutes': recipe.prepTimeMinutes.toString()})}');
    }

    if (recipe.description != null && recipe.description!.isNotEmpty) {
      buffer.writeln('${LocaleKeys.description.tr()}: ${recipe.description}');
    }

    if (recipe.ingredientList.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(LocaleKeys.ingredients.tr());
      for (final ingredient in recipe.ingredientList) {
        final text = ingredient.text;
        if (text != null && text.isNotEmpty) {
          buffer.writeln('• $text');
        }
      }
    }

    if (recipe.steps.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(LocaleKeys.steps.tr());
      for (var i = 0; i < recipe.steps.length; i++) {
        final text = recipe.steps[i].text;
        if (text != null && text.isNotEmpty) {
          buffer.writeln('${i + 1}. $text');
        }
      }
    }

    return buffer.toString().trimRight();
  }
}
