import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/core/widgets/snack_bar_helper.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/empty_list_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/nav_drawer.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/recipe_tile_widget.dart';

class ListRecipesPage extends StatelessWidget {
  final FilteredRecipesStore store;
  final NavigationService navigationService;

  const ListRecipesPage(
      {super.key, required this.store, required this.navigationService});

  @override
  Widget build(BuildContext context) {
    void sureDeleteRecipe(Recipe recipe) {
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

    void longPressActions(Recipe recipe) {
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
                sureDeleteRecipe(recipe);
              },
              child: Text(LocaleKeys.delete.tr()),
            ),
          ],
        ),
      );
    }

    store.getAllRecipes();
    return ReactionBuilder(
      builder: (context) => reaction(
        (_) => store.lastFailure,
        (failure) {
          if (failure != null) {
            SnackBarHelper.showError(context, LocaleKeys.error_load_recipes.tr());
          }
        },
      ),
      child: Scaffold(
        drawer: NavDrawer(navigationService: navigationService),
        appBar: AppBar(
          title: Text(LocaleKeys.my_recipe_book.tr()),
          actions: [
            Observer(
              builder: (_) => IconButton(
                icon: Icon(store.showFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                tooltip: LocaleKeys.favorites.tr(),
                onPressed: () => store.toggleFavoritesOnly(),
              ),
            ),
            PopupMenuButton<SortOption>(
              icon: Icon(Icons.sort),
              tooltip: LocaleKeys.sort_by.tr(),
              onSelected: store.setSortOption,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: SortOption.name,
                  child: Text(LocaleKeys.sort_by_name.tr()),
                ),
                PopupMenuItem(
                  value: SortOption.type,
                  child: Text(LocaleKeys.sort_by_type.tr()),
                ),
                PopupMenuItem(
                  value: SortOption.difficulty,
                  child: Text(LocaleKeys.sort_by_difficulty.tr()),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.search.tr(),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                ),
                onChanged: store.setSearchQuery,
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (store.filteredRecipes.isEmpty) {
                    if (store.showFavoritesOnly) {
                      return EmptyListWidget(
                        message: LocaleKeys.no_favorites_yet.tr(),
                        icon: Icons.favorite_border,
                      );
                    }
                    if (store.searchQuery.isNotEmpty) {
                      return EmptyListWidget(
                        message: LocaleKeys.no_results_found.tr(),
                        icon: Icons.search_off,
                      );
                    }
                    return EmptyListWidget(
                      message: LocaleKeys.no_recipe_add_yet.tr(),
                    );
                  }

                  return ListView.builder(
                    itemCount: store.filteredRecipes.length,
                    itemBuilder: (_, index) {
                      Recipe recipe = store.filteredRecipes[index];
                      return RecipeTileWidget(
                          recipe,
                          () => navigationService
                              .navigateTo('/show_recipe', arguments: recipe)
                              .whenComplete(() => store.getAllRecipes()),
                          () => longPressActions(recipe),
                          onFavoriteToggle: () => store.toggleFavorite(recipe));
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigationService
                .navigateTo('/new_recipe')
                .whenComplete(() => store.getAllRecipes());
          },
          tooltip: LocaleKeys.add_new_recipe.tr(),
          child: Icon(Icons.add),
        )),
    );
  }
}
