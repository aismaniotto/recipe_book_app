import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/recipe_infos_entry_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/custom_reordenable_listview.dart';

class InputRecipePage extends StatelessWidget {
  final RecipeStore store;
  final NavigationService navigationService;

  const InputRecipePage(
      {Key? key, required this.store, required this.navigationService})
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
            TextButton(
              onPressed: () => navigationService.pop(true),
              child: Text(LocaleKeys.exit.tr()),
            ),
            TextButton(
              onPressed: () => navigationService.pop(false),
              child: Text(LocaleKeys.stay.tr()),
            ),
          ],
        ),
      ).then((value) => value as bool);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                store.title.isEmpty ? LocaleKeys.new_recipe.tr() : store.title),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  shape: CircleBorder(
                      side: BorderSide(
                    color: Colors.transparent,
                  )),
                ),
                onPressed: () async {
                  await store.saveRecipe();
                },
                child: Text(LocaleKeys.save.tr()),
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
