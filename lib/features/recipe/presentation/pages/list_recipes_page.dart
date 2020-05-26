import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/empty_list_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/loading_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/recipe_tile_widget.dart';

class ListRecipesPage extends StatelessWidget {
  final _store = ioc<FilteredRecipesStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My recipe app'),
        ),
        body: Observer(
          builder: (_) {
            _store.getAllRecipes();
            if (_store.filteredRecipes == null) {
              return LoadingWidget();
            }

            if (_store.filteredRecipes.isEmpty) {
              return EmptyListWidget();
            }

            return ListView.builder(
              itemCount: _store.filteredRecipes.length,
              itemBuilder: (_, index) {
                Recipe recipe = _store.filteredRecipes[index];
                return RecipeTileWidget(
                    recipe, () => {/* TODO: navigate to recipe page */});
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO:new recipe page
          },
          tooltip: 'Increment Counter',
          child: Icon(Icons.add),
        ));
  }
}
