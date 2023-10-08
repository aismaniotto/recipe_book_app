import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:uuid/uuid.dart';

enum Type { breakfast, meal, side, snack, drink, dessert, other }
enum Difficulty { easy, medium, hard }

class Recipe {
  late String id;
  String title;
  String? description;
  Type type;
  int? quantityPeopleServide;
  Difficulty difficulty;
  List<IdentificableText> ingredientList;
  List<IdentificableText> steps;
  //TODO:String picturePath;

  Recipe(
      {id,
      title,
      this.description,
      type,
      this.quantityPeopleServide,
      difficulty,
      ingredientList,
      steps})
      : id = id ?? Uuid().v4(),
        title = title ?? '',
        type = type ?? Type.other,
        difficulty = difficulty ?? Difficulty.easy,
        ingredientList = ingredientList ?? [],
        steps = steps ?? [];
}
