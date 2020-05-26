import 'package:flutter/material.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeTileWidget extends StatelessWidget {
  final Recipe recipe;
  final Function onTap;

  const RecipeTileWidget(this.recipe, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(recipe.name),
        onTap: onTap,
        subtitle: Text(recipe.description),
      ),
    );
  }
}
