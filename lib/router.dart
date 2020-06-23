import 'package:flutter/material.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/new_recipe_page.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/show_recipe_page.dart';

import 'core/IoC/ioc.dart';
import 'features/recipe/domain/usecases/delete_recipe.dart';
import 'features/recipe/presentation/pages/list_recipes_page.dart';
import 'features/recipe/presentation/stores/filtered_recipes_store.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/list_recipes':
        return MaterialPageRoute(
            builder: (_) => ListRecipesPage(
                  store: ioc<FilteredRecipesStore>(),
                  navigationService: ioc(),
                ));
      case '/show_recipe':
        var recipe = settings.arguments as Recipe;
        return MaterialPageRoute(
            builder: (_) => ShowRecipePage(
                  recipe: recipe,
                  deleteRecipe: ioc<DeleteRecipe>(),
                  navigationService: ioc(),
                ));
      case '/new_recipe':
        return MaterialPageRoute(
            builder: (_) => NewRecipePage(
                  store: ioc(),
                  navigationService: ioc(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
