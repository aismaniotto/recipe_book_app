import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';

part 'filtered_recipes_store.g.dart';

class FilteredRecipesStore extends _FilteredRecipesStore
    with _$FilteredRecipesStore {
  FilteredRecipesStore(GetAllRecipes getAllRecipes) : super(getAllRecipes);
}

abstract class _FilteredRecipesStore with Store {
  final GetAllRecipes _getAllRecipes;

  @observable
  List<Recipe> _recipes;

  @observable
  String filter;

  _FilteredRecipesStore(this._getAllRecipes);

  @computed
  ObservableList<Recipe> get filteredRecipes {
    //TODO: apply filter by name
    if (_recipes != null) {
      return _recipes.asObservable();
    }
    return null;
  }

  @action
  getAllRecipes() async {
    _recipes = await _getAllRecipes();
  }
}
