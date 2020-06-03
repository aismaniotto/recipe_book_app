import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import "package:charcode/html_entity.dart";

class Ingredient {
  final String name;
  final num quantity;
  final String measure; //TODO:enum or new class

  Ingredient(this.name, this.quantity, this.measure);

  @override
  String toString() {
    var commonFraction = false;
    var charCodeFraction = 0;

    var fraction = quantity - quantity.floor();
    if (fraction == 0.25) {
      commonFraction = true;
      charCodeFraction = $frac14;
    } else if (fraction == 0.5) {
      commonFraction = true;
      charCodeFraction = $frac12;
    } else if (fraction == 0.75) {
      commonFraction = true;
      charCodeFraction = $frac34;
    }

    /**
     * by the clean architecture my domain should not depend on any framework/library/package, 
     * but, to make the things easily on the future and avoid repeated this code, I decided for 
     * this little dependency
     */

    if (commonFraction) {
      return LocaleKeys.ingredient_partial.tr(namedArgs: {
        'quantity': quantity.floor().toString(),
        'fraction': String.fromCharCode(charCodeFraction),
        'measure': measure,
        'name': name
      });
    }

    return LocaleKeys.ingredient_full.tr(namedArgs: {
      'quantity': quantity.floor().toString(),
      'measure': measure,
      'name': name
    });
  }
}
