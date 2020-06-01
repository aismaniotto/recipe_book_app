import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeTileWidget extends StatelessWidget {
  final Recipe recipe;
  final Function onTap;

  const RecipeTileWidget(this.recipe, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: getIconType(recipe.type),
      title: Text(recipe.name),
      subtitle: Text(recipe.description),
      trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('x${recipe.quantityPeopleServide}'),
            getIconDifficulty(recipe.difficulty)
          ]),
      onTap: onTap,
    ));
  }

  Icon getIconType(Type recipeType) {
    IconData icon;
    switch (recipeType) {
      case Type.breakfast:
        icon = FontAwesomeIcons.breadSlice;
        break;
      case Type.meal:
        icon = FontAwesomeIcons.utensils;
        break;
      case Type.side:
        icon = FontAwesomeIcons.conciergeBell;
        break;
      case Type.snack:
        icon = FontAwesomeIcons.cookieBite;
        break;
      case Type.drink:
        icon = FontAwesomeIcons.cocktail;
        break;
      case Type.dessert:
        icon = FontAwesomeIcons.iceCream;
        break;
      case Type.other:
        icon = FontAwesomeIcons.book;
        break;

      default:
        icon = FontAwesomeIcons.book;
    }
    return Icon(icon, size: 45.0);
  }

  Icon getIconDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return Icon(
          Icons.brightness_3,
          color: Colors.green,
        );
        break;
      case Difficulty.medium:
        return Icon(
          Icons.brightness_2,
          color: Colors.yellow,
        );
        break;
      case Difficulty.hard:
        return Icon(
          Icons.brightness_1,
          color: Colors.orange,
        );
        break;
      default:
        return Icon(
          Icons.not_interested,
          color: Colors.black,
        );
    }
  }
}
