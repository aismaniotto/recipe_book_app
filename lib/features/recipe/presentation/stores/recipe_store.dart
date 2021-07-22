import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';

part 'recipe_store.g.dart';

class RecipeStore extends _RecipeStore with _$RecipeStore {
  RecipeStore(AddRecipe addRecipe, UpdateRecipe updateRecipe, {Recipe? recipe})
      : super(addRecipe, updateRecipe, recipe: recipe);
}

abstract class _RecipeStore with Store {
  final AddRecipe _addRecipe;
  final UpdateRecipe _updateRecipe;
  bool isUpdate = false;
  late Recipe recipe;

  _RecipeStore(this._addRecipe, this._updateRecipe, {Recipe? recipe}) {
    if (recipe == null) {
      this.recipe = Recipe(
          ingredientList: [IdentificableText('')].asObservable(),
          steps: [IdentificableText('')].asObservable());
    } else {
      isUpdate = true;
      this.recipe = recipe;
      this.recipe.ingredientList = recipe.ingredientList.asObservable();
      this.recipe.steps = recipe.steps.asObservable();
    }
  }

  String get title => recipe.title;
  @action
  void changeTitle(String newTitle) => recipe.title = newTitle;

  String? get description => recipe.description;
  @action
  void changeDescription(String newDescription) =>
      recipe.description = newDescription;

  Type get type => recipe.type;
  @action
  void changeType(Type? newType) {
    if (newType != null) {
      recipe.type = newType;
    }
  }

  int? get quantityPeopleServide => recipe.quantityPeopleServide;
  @action
  void changeQuantityPeopleServide(int newQuantityPeopleServide) =>
      recipe.quantityPeopleServide = newQuantityPeopleServide;

  Difficulty get difficulty => recipe.difficulty;
  void changeDifficulty(Difficulty? newDifficulty) {
    if (newDifficulty != null) {
      recipe.difficulty = newDifficulty;
    }
  }

  List<IdentificableText> get ingredientList => recipe.ingredientList;

  @action
  void addNewIngredient() {
    recipe.ingredientList.add(IdentificableText(''));
  }

  @action
  void deleteIngredient(int index) {
    recipe.ingredientList.removeAt(index);
  }

  @action
  void changeIngredient(String newIngredient, int index) {
    recipe.ingredientList[index].text = newIngredient;
  }

  @action
  void reorderIngredient(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText ingredient = recipe.ingredientList.removeAt(oldIndex);
    recipe.ingredientList.insert(newIndex, ingredient);
  }

  List<IdentificableText> get steps => recipe.steps;
  @action
  void addNewStep() {
    recipe.steps.add(IdentificableText(''));
  }

  @action
  void deleteStep(int index) {
    recipe.steps.removeAt(index);
  }

  @action
  void changeStep(String newStep, int index) {
    recipe.steps[index].text = newStep;
  }

  @action
  void reorderStep(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    IdentificableText step = recipe.steps.removeAt(oldIndex);
    recipe.steps.insert(newIndex, step);
  }

  @action
  Future saveRecipe() async {
    if (title.isEmpty) return;
    isUpdate ? await _updateRecipe(recipe) : await _addRecipe(recipe);
    ioc<NavigationService>().goBack();
  }
}
