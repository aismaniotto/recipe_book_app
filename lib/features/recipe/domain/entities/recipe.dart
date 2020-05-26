import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';

enum Type { breakfast, meal, side, snack, drink, dessert, other }
enum Difficulty { easy, medium, hard }

class Recipe {
  final String id;
  final String name;
  final String description;
  final Type type;
  final int quantityPeopleServide;
  final Difficulty difficulty;
  final List<Ingredient> ingredientList;
  final List<String> steps;
  //TODO:String picturePath;

  Recipe(
      this.id,
      this.name,
      this.description,
      this.type,
      this.quantityPeopleServide,
      this.difficulty,
      this.ingredientList,
      this.steps);
}
