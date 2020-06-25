import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';

part 'recipe_store.g.dart';

class RecipeStore extends _RecipeStore with _$RecipeStore {
  RecipeStore(AddRecipe addRecipe, UpdateRecipe updateRecipe, {Recipe recipe})
      : super(addRecipe, updateRecipe, recipe: recipe);
}

abstract class _RecipeStore with Store {
  final AddRecipe _addRecipe;
  final UpdateRecipe _updateRecipe;
  bool isUpdate = false;
  Recipe recipe;

  _RecipeStore(this._addRecipe, this._updateRecipe, {this.recipe}) {
    if (recipe == null) {
      recipe = Recipe(
          ingredientList: [IdentificableText('')].asObservable(),
          steps: [IdentificableText('')].asObservable());
    } else {
      isUpdate = true;
      recipe.ingredientList = recipe.ingredientList.asObservable();
      recipe.steps = recipe.steps.asObservable();
    }
  }

  String get title => recipe.title ?? '';
  @action
  changeTitle(String newTitle) => recipe.title = newTitle;

  String get description => recipe.description;
  @action
  changeDescription(String newDescription) =>
      recipe.description = newDescription;

  Type get type => recipe.type;
  @action
  changeType(Type newType) => recipe.type = newType;

  int get quantityPeopleServide => recipe.quantityPeopleServide;
  @action
  changeQuantityPeopleServide(int newQuantityPeopleServide) =>
      recipe.quantityPeopleServide = newQuantityPeopleServide;

  Difficulty get difficulty => recipe.difficulty;
  changeDifficulty(Difficulty newDifficulty) =>
      recipe.difficulty = newDifficulty;

  List<IdentificableText> get ingredientList => recipe.ingredientList;

  @action
  addNewIngredient() {
    recipe.ingredientList.add(IdentificableText(''));
  }

  @action
  deleteIngredient(int index) {
    recipe.ingredientList.removeAt(index);
  }

  @action
  changeIngredient(String newIngredient, int index) {
    recipe.ingredientList[index].text = newIngredient;
  }

  @action
  reorderIngredient(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText ingredient = recipe.ingredientList.removeAt(oldIndex);
    recipe.ingredientList.insert(newIndex, ingredient);
  }

  List<IdentificableText> get steps => recipe.steps;
  @action
  addNewStep() {
    recipe.steps.add(IdentificableText(''));
  }

  @action
  deleteStep(int index) {
    recipe.steps.removeAt(index);
  }

  @action
  changeStep(String newStep, int index) {
    recipe.steps[index].text = newStep;
  }

  @action
  reorderStep(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText step = recipe.steps.removeAt(oldIndex);
    recipe.steps.insert(newIndex, step);
  }

  @action
  Future saveRecipe() async {
    if (title.isEmpty || type == null || difficulty == null) return;
    isUpdate ? await _updateRecipe(recipe) : await _addRecipe(recipe);
    ioc<NavigationService>().goBack();
  }
}
