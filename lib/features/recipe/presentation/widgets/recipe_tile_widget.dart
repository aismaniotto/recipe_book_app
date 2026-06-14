import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeTileWidget extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const RecipeTileWidget(this.recipe, this.onTap, this.onLongPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: getIconType(recipe.type),
      title: Text(recipe.title),
      subtitle: Text(
        recipe.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.fade,
      ),
      trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            recipe.quantityPeopleServide != null
                ? Text('x${recipe.quantityPeopleServide}')
                : Text(''),
            getIconDifficulty(recipe.difficulty)
          ]),
      onTap: onTap,
      onLongPress: onLongPress,
    ));
  }

  FaIcon getIconType(Type recipeType) {
    FaIconData icon;
    switch (recipeType) {
      case Type.breakfast:
        icon = FontAwesomeIcons.breadSlice;
        break;
      case Type.meal:
        icon = FontAwesomeIcons.utensils;
        break;
      case Type.side:
        icon = FontAwesomeIcons.bellConcierge;
        break;
      case Type.snack:
        icon = FontAwesomeIcons.cookieBite;
        break;
      case Type.drink:
        icon = FontAwesomeIcons.martiniGlassCitrus;
        break;
      case Type.dessert:
        icon = FontAwesomeIcons.iceCream;
        break;
      case Type.other:
        icon = FontAwesomeIcons.book;
        break;
    }
    return FaIcon(icon, size: 45.0);
  }

  Icon getIconDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return Icon(
          Icons.brightness_3,
          color: Colors.green,
        );
      case Difficulty.medium:
        return Icon(
          Icons.brightness_2,
          color: Colors.yellow,
        );
      case Difficulty.hard:
        return Icon(
          Icons.brightness_1,
          color: Colors.orange,
        );
    }
  }
}
