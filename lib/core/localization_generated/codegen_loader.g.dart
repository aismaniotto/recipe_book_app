// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

    static const Map<String,dynamic> en = {
  "my_recipe_book": "My recipe book",
  "recipe_book": "Recipe book",
  "recipe": "Recipe",
  "ingredients": "Ingredients",
  "ingredient": {
    "full": "{quantity} {measure} of {name}",
    "partial": "{quantity} {fraction} {measure} of {name}"
  },
  "steps": "steps",
  "add_new_recipe": "Add new recipe",
  "no_recipe_add_yet": "No recipe add yet...",
  "type_": "Type: ",
  "serve_": "Serve: ",
  "difficulty_": "Difficulty: ",
  "description_": "Description: ",
  "person": {
    "person": "person",
    "people": "people"
  },
  "edit": "edit",
  "delete": "delete",
  "difficulty": {
    "easy": "easy",
    "medium": "medium",
    "hard": "hard"
  },
  "recipe_type": {
    "breakfast": "breakfast",
    "meal": "meal",
    "side": "side",
    "snack": "snack",
    "drink": "drink",
    "dessert": "dessert",
    "some_other": "other"
  },
  "unknow": "unknow"
};
  static const Map<String,dynamic> pt = {
  "my_recipe_book": "Meu livro de receitas",
  "recipe_book": "Livro de receitas",
  "recipe": "Receita",
  "ingredients": "Ingredientes",
  "ingredient": {
    "full": "{quantity} {measure} de {name}",
    "partial": "{quantity} {fraction} {measure} de {name}"
  },
  "steps": "Modo de preparo",
  "add_new_recipe": "Adicionar nova receita",
  "no_recipe_add_yet": "Nenhuma receita adiciona ainda...",
  "type_": "Tipo: ",
  "serve_": "Serve: ",
  "difficulty_": "Dificuldade: ",
  "description_": "Descrição: ",
  "person": {
    "person": "pessoa",
    "people": "pessoas"
  },
  "edit": "Editar",
  "delete": "Deletar",
  "difficulty": {
    "easy": "fácil",
    "medium": "média",
    "hard": "difícil"
  },
  "recipe_type": {
    "breakfast": "café da manhã",
    "meal": "refeição",
    "side": "acompanhamento",
    "snack": "lanche",
    "drink": "bebida",
    "dessert": "sobremesa",
    "some_other": "outro"
  },
  "unknow": "desconhecido"
};
  static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "pt": pt};
}
