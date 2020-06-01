import 'package:flutter/material.dart';
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
      name: recipe.name,
      description: recipe.description,
      type: recipe.type,
      qtdPeopleServide: recipe.quantityPeopleServide,
      difficulty: recipe.difficulty,
    ));
    columnWidgets.add(TitleListWidget('Ingredients'));
    columnWidgets.addAll(prepareList<Ingredient>(recipe.ingredientList));
    columnWidgets.add(TitleListWidget('Steps'));
    columnWidgets.addAll(prepareList<String>(recipe.steps));

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //TODO: add action to edit.
              print('edit');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              //TODO: add action to delete.
              print('delete');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          runSpacing: 5,
          children: columnWidgets,
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
