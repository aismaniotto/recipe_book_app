import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/empty_list_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/nav_drawer.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/recipe_tile_widget.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class ListRecipesPage extends StatelessWidget {
  final FilteredRecipesStore store;
  final NavigationService navigationService;

  const ListRecipesPage(
      {Key? key, required this.store, required this.navigationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _sureDeleteRecipe(Recipe recipe) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(LocaleKeys.attention.tr()),
            content: Text(LocaleKeys.sure_delete.tr()),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleKeys.yes.tr()),
                onPressed: () async {
                  await store.deleteRecipe(recipe);
                  store.getAllRecipes();
                  navigationService.pop(false);
                },
              ),
              TextButton(
                child: Text(LocaleKeys.no.tr()),
                onPressed: () {
                  navigationService.pop(false);
                },
              ),
            ],
          );
        },
      );
    }

    void _longPressActions(Recipe recipe) {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                navigationService
                    .navigateTo('/update_recipe', arguments: recipe)
                    .whenComplete(() => store.getAllRecipes());
                navigationService.pop(false);
              },
              child: Text(LocaleKeys.edit.tr()),
            ),
            SimpleDialogOption(
              onPressed: () {
                navigationService.pop(false);
                _sureDeleteRecipe(recipe);
              },
              child: Text(LocaleKeys.delete.tr()),
            ),
          ],
        ),
      );
    }

    store.getAllRecipes();
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(LocaleKeys.my_recipe_book.tr()),
        ),
        body: Observer(
          builder: (_) {
            if (store.filteredRecipes.isEmpty) {
              return EmptyListWidget();
            }

            return ListView.builder(
              itemCount: store.filteredRecipes.length,
              itemBuilder: (_, index) {
                Recipe recipe = store.filteredRecipes[index];
                return RecipeTileWidget(
                    recipe,
                    () => {
                          navigationService
                              .navigateTo('/show_recipe', arguments: recipe)
                              .whenComplete(() => store.getAllRecipes())
                        },
                    () => _longPressActions(recipe));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigationService
                .navigateTo('/new_recipe')
                .whenComplete(() => store.getAllRecipes());
          },
          tooltip: LocaleKeys.add_new_recipe.tr(),
          child: Icon(Icons.add),
        ));
  }
}
