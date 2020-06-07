import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';

part 'recipe_store.g.dart';

class RecipeStore extends _RecipeStore with _$RecipeStore {
  RecipeStore(AddRecipe addRecipe) : super(addRecipe);
}

abstract class _RecipeStore with Store {
  final AddRecipe _addRecipe;

  @observable
  String title = '';
  @action
  changeTitle(String newTitle) => title = newTitle;

  @observable
  String description;
  @action
  changeDescription(String newDescription) => description = newDescription;

  @observable
  Type type;
  @action
  changeType(Type newType) => type = newType;

  @observable
  int quantityPeopleServide;
  @action
  changeQuantityPeopleServide(int newQuantityPeopleServide) =>
      quantityPeopleServide = newQuantityPeopleServide;

  @observable
  Difficulty difficulty;
  changeDifficulty(Difficulty newDifficulty) => difficulty = newDifficulty;

  @observable
  List<Ingredient> ingredientList = List<Ingredient>();

  @observable
  List<String> steps = List<String>();

  _RecipeStore(this._addRecipe);

  @action
  saveRecipe() async {
    if (title.isEmpty || type == null || difficulty == null) return;
    _addRecipe(
        title: title,
        description: description,
        type: type,
        quantityPeopleServide: quantityPeopleServide,
        difficulty: difficulty,
        ingredientList: ingredientList,
        steps: steps);
  }
}
