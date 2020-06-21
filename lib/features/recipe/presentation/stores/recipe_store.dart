import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';

part 'recipe_store.g.dart';

class RecipeStore extends _RecipeStore with _$RecipeStore {
  RecipeStore(AddRecipe addRecipe) : super(addRecipe);
}

abstract class _RecipeStore with Store {
  final AddRecipe _addRecipe;

  _RecipeStore(this._addRecipe);

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
  List<IdentificableText> ingredientList =
      [IdentificableText('')].asObservable();

  @action
  addNewIngredient() {
    ingredientList.add(IdentificableText(''));
  }

  @action
  deleteIngredient(int index) {
    ingredientList.removeAt(index);
  }

  @action
  changeIngredient(String newIngredient, int index) {
    ingredientList[index].text = newIngredient;
  }

  @action
  reorderIngredient(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText ingredient = ingredientList.removeAt(oldIndex);
    ingredientList.insert(newIndex, ingredient);
  }

  @observable
  ObservableList<IdentificableText> steps =
      [IdentificableText('')].asObservable();
  @action
  addNewStep() {
    steps.add(IdentificableText(''));
  }

  @action
  deleteStep(int index) {
    steps.removeAt(index);
  }

  @action
  changeStep(String newStep, int index) {
    steps[index].text = newStep;
  }

  @action
  reorderStep(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText step = steps.removeAt(oldIndex);
    steps.insert(newIndex, step);
  }

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
