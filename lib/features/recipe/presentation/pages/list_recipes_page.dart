import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/empty_list_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/loading_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/recipe_tile_widget.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class ListRecipesPage extends StatelessWidget {
  final FilteredRecipesStore store;
  final NavigationService navigationService;

  const ListRecipesPage(
      {Key key, @required this.store, @required this.navigationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.getAllRecipes();
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.my_recipe_book.tr()),
        ),
        body: Observer(
          builder: (_) {
            if (store.filteredRecipes == null) {
              return LoadingWidget();
            }

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
                        });
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            navigationService
                .navigateTo('/new_recipe')
                .whenComplete(() => store.getAllRecipes())
          },
          tooltip: LocaleKeys.add_new_recipe.tr(),
          child: Icon(Icons.add),
        ));
  }
}
