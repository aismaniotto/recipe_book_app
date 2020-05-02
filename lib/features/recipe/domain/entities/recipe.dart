import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';
import 'package:uuid/uuid.dart';

class Recipe {
  final String id = Uuid().v4(); 
  String name;
  String description;
  String type;//TODO:enum or new class. Ex.: breakfast, lunch, supper, or snack;
  int quantityPeopleServide;
  //TODO:String difficultLevel; // enum or new class
  List<Ingredient> ingredientList; // TODO: encapsulate methods
  List<String> steps; // TODO: encapsulate methods
  //TODO:String picturePath;

  Recipe(this.name, this.description, this.type, this.quantityPeopleServide,
      this.ingredientList, this.steps);
}
