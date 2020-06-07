import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/input/recipe_infos_entry_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';

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
                  Navigator.of(context).pop();
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
                    child: RecipeInfosEntryWidget(
                      onTitleChanged: _store.changeTitle,
                      onDescriptionChanged: _store.changeDescription,
                      onTypeChanged: _store.changeType,
                      onQuantityPeopleServideChanged:
                          _store.changeQuantityPeopleServide,
                      onDifficultyChanged: _store.changeDifficulty,
                    )),
              ),
              Icon(Icons.restaurant_menu),
              Icon(Icons.list),
            ],
          )),
    );
  }
}
