import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/ingredient.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/item_list_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/recipe_header_widget.dart';
import 'package:recipe_book_app/features/recipe/presentation/widgets/title_list_widget.dart';

class ShowRecipePage extends StatelessWidget {
  final Recipe recipe;

  ShowRecipePage({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var columnWidgets = List<Widget>();

    columnWidgets.add(RecipeHeaderWidget(
      name: recipe.title,
      description: recipe.description,
      type: recipe.type,
      qtdPeopleServide: recipe.quantityPeopleServide,
      difficulty: recipe.difficulty,
    ));
    columnWidgets.add(TitleListWidget(LocaleKeys.ingredients.tr()));
    columnWidgets.addAll(prepareList<Ingredient>(recipe.ingredientList));
    columnWidgets.add(TitleListWidget(LocaleKeys.steps.tr()));
    columnWidgets.addAll(prepareList<String>(recipe.steps));

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: LocaleKeys.edit.tr(),
            onPressed: () {
              //TODO: add action to edit.
              print('edit');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: LocaleKeys.delete.tr(),
            onPressed: () {
              //TODO: add action to delete.
              print('delete');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runSpacing: 5,
            children: columnWidgets,
          ),
        ),
      ),
    );
  }

  List<Widget> prepareList<T>(List<T> list) {
    var widgetList = List<Widget>();
    list.forEach(
        (element) => widgetList.add(ItemListWidget(element.toString())));

    return widgetList;
  }
}
