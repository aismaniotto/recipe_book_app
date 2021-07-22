import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';

part 'filtered_recipes_store.g.dart';

class FilteredRecipesStore extends _FilteredRecipesStore
    with _$FilteredRecipesStore {
  FilteredRecipesStore(GetAllRecipes getAllRecipes, DeleteRecipe deleteRecipe)
      : super(getAllRecipes, deleteRecipe);
}

abstract class _FilteredRecipesStore with Store {
  final GetAllRecipes _getAllRecipes;
  final DeleteRecipe _deleteRecipe;

  @observable
  List<Recipe> _recipes = List.empty();

  @observable
  String filter = '';

  _FilteredRecipesStore(this._getAllRecipes, this._deleteRecipe);

  @computed
  ObservableList<Recipe> get filteredRecipes {
    //TODO: apply filter by name
    return _recipes.asObservable();
  }

  @action
  Future getAllRecipes() async {
    _recipes = await _getAllRecipes();
  }

  @action
  Future deleteRecipe(Recipe recipe) async {
    await _deleteRecipe(recipe);
  }
}
