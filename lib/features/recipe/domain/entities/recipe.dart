import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';

enum Type { breakfast, meal, side, snack, drink, dessert, other }
enum Difficulty { easy, medium, hard }

class Recipe {
  final String id;
  final String title;
  final String description;
  final Type type;
  final int quantityPeopleServide;
  final Difficulty difficulty;
  final List<IdentificableText> ingredientList;
  final List<IdentificableText> steps;
  //TODO:String picturePath;

  Recipe(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.quantityPeopleServide,
      this.difficulty,
      this.ingredientList,
      this.steps});
}
