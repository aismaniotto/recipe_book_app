import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/recipe_infos_entry_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/custom_reordenable_listview.dart';

class NewRecipePage extends StatelessWidget {
  final _store = ioc<RecipeStore>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.new_recipe.tr()),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                await _store.saveRecipe();
              },
              child: Text(LocaleKeys.save.tr()),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
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
                      title: _store.title,
                      onTitleChanged: _store.changeTitle,
                      description: _store.description,
                      onDescriptionChanged: _store.changeDescription,
                      type: _store.type,
                      onTypeChanged: _store.changeType,
                      quantityPeopleServide: _store.quantityPeopleServide,
                      onQuantityPeopleServideChanged:
                          _store.changeQuantityPeopleServide,
                      difficulty: _store.difficulty,
                      onDifficultyChanged: _store.changeDifficulty,
                    );
                  })),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomReordenableListView(
                items: _store.ingredientList,
                onItemChange: _store.changeIngredient,
                onItemDelete: _store.deleteIngredient,
                onItemAdd: _store.addNewIngredient,
                onItemReorder: _store.reorderIngredient,
                hintTextItem: LocaleKeys.ingredient_hint.tr(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomReordenableListView(
                  items: _store.steps,
                  onItemChange: _store.changeStep,
                  onItemDelete: _store.deleteStep,
                  onItemAdd: _store.addNewStep,
                  onItemReorder: _store.reorderStep),
            ),
          ],
        ),
      ),
    );
  }
}
