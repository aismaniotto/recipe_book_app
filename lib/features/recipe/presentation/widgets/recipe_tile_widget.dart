import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeTileWidget extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback? onFavoriteToggle;

  const RecipeTileWidget(this.recipe, this.onTap, this.onLongPress,
      {super.key, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: getIconType(recipe.type),
      title: Text(recipe.title),
      subtitle: Row(
        children: [
          if (recipe.description != null && recipe.description!.isNotEmpty)
            Expanded(
              child: Text(
                recipe.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (recipe.prepTimeMinutes != null) ...[
            if (recipe.description != null && recipe.description!.isNotEmpty)
              SizedBox(width: 8),
            Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
            SizedBox(width: 2),
            Text(LocaleKeys.prep_time_minutes.tr(namedArgs: {'minutes': recipe.prepTimeMinutes.toString()}),
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
      ),
      trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: onFavoriteToggle,
              child: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
            SizedBox(height: 4),
            getIconDifficulty(recipe.difficulty),
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
