import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:uuid/uuid.dart';

enum Type { breakfast, meal, side, snack, drink, dessert, other }
enum Difficulty { easy, medium, hard }

class Recipe {
  String id;
  String title;
  String description;
  Type type;
  int quantityPeopleServide;
  Difficulty difficulty;
  List<IdentificableText> ingredientList;
  List<IdentificableText> steps;
  //TODO:String picturePath;

  Recipe(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.quantityPeopleServide,
      this.difficulty,
      this.ingredientList,
      this.steps}) {
    if (id == null) {
      id = Uuid().v4();
    }
  }
}
