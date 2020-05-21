import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  //TODO:final String type;//TODO:enum or new class. Ex.: breakfast, lunch, supper, or snack;
  //TODO:final int quantityPeopleServide;
  //TODO:String difficultLevel; // enum or new class
  final List<Ingredient> ingredientList;
  final List<String> steps;
  //TODO:String picturePath;

  Recipe(this.id, this.name, this.description, this.ingredientList, this.steps);
}
