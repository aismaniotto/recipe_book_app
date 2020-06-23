import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/recipe_infos_entry_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/custom_reordenable_listview.dart';

class NewRecipePage extends StatelessWidget {
  final RecipeStore store;
  final NavigationService navigationService;

  const NewRecipePage(
      {Key key, @required this.store, @required this.navigationService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(LocaleKeys.attention.tr()),
              content: Text(LocaleKeys.wish_leave.tr()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => navigationService.pop(false),
                  child: Text(LocaleKeys.stay.tr()),
                ),
                FlatButton(
                  onPressed: () => navigationService.pop(true),
                  child: Text(LocaleKeys.exit.tr()),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.new_recipe.tr()),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () async {
                  await store.saveRecipe();
                },
                child: Text(LocaleKeys.save.tr()),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: LocaleKeys.recipe.tr()),
                Tab(text: LocaleKeys.ingredients.tr()),
                Tab(text: LocaleKeys.steps.tr()),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Observer(builder: (_) {
                      return RecipeInfosEntryWidget(
                        title: store.title,
                        onTitleChanged: store.changeTitle,
                        description: store.description,
                        onDescriptionChanged: store.changeDescription,
                        type: store.type,
                        onTypeChanged: store.changeType,
                        quantityPeopleServide: store.quantityPeopleServide,
                        onQuantityPeopleServideChanged:
                            store.changeQuantityPeopleServide,
                        difficulty: store.difficulty,
                        onDifficultyChanged: store.changeDifficulty,
                      );
                    })),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomReordenableListView(
                  items: store.ingredientList,
                  onItemChange: store.changeIngredient,
                  onItemDelete: store.deleteIngredient,
                  onItemAdd: store.addNewIngredient,
                  onItemReorder: store.reorderIngredient,
                  hintTextItem: LocaleKeys.ingredient_hint.tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomReordenableListView(
                    items: store.steps,
                    onItemChange: store.changeStep,
                    onItemDelete: store.deleteStep,
                    onItemAdd: store.addNewStep,
                    onItemReorder: store.reorderStep),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
