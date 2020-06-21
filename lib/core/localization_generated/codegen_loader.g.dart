// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

    static const Map<String,dynamic> pt = {
  "___comment1": "RECEITAS",
  "recipe": "Receita",
  "my_recipe_book": "Meu livro de receitas",
  "recipe_book": "Livro de receitas",
  "recipe_title": "Nome da receita",
  "new_recipe": "Nova receita",
  "add_new_recipe": "Adicionar nova receita",
  "no_recipe_add_yet": "Nenhuma receita adiciona ainda...",
  "___comment2": "INGREDIENTES",
  "ingredients": "Ingredientes",
  "ingredient": {
    "full": "{quantity} {measure} de {name}",
    "partial": "{quantity} {fraction} {measure} de {name}"
  },
  "add_ingredient": "Adicionar ingrediente",
  "delete_ingredient": "Excluir ingrediente",
  "move_ingredient": "Mover ingrediente",
  "ingredient_hint": "ex.: 100g de açúcar",
  "___comment3": "PASSOS",
  "steps": "Modo de preparo",
  "add_step": "Adicionar passo",
  "delete_step": "Excluir passo",
  "move_step": "Mover passo",
  "___comment4": "OUTROS",
  "title_required": "Por favor, informe um título",
  "type": "Tipo",
  "type_required": "Por favor, selecione um tipo",
  "serve": "Serve",
  "description": "Descrição",
  "peoples_serves": "Serve quantas pessoas",
  "person": {
    "person": "pessoa",
    "people": "pessoas"
  },
  "difficulty_level": "Dificuldade",
  "difficulty_required": "Por favor, selecione um nível",
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
  "___comment0": "GERAIS",
  "unknow": "desconhecido",
  "not_informed": "não informado",
  "undefined": "indefinido",
  "save": "Salvar",
  "edit": "Editar",
  "delete": "Deletar"
};
  static const Map<String,dynamic> en = {
  "___comment1": "RECIPES",
  "recipe": "Recipe",
  "my_recipe_book": "My recipe book",
  "recipe_book": "Recipe book",
  "recipe_title": "Title of the recipe",
  "new_recipe": "New recipe",
  "add_new_recipe": "Add new recipe",
  "no_recipe_add_yet": "No recipe add yet...",
  "___comment2": "INGREDIENTS",
  "ingredients": "Ingredients",
  "ingredient": {
    "full": "{quantity} {measure} of {name}",
    "partial": "{quantity} {fraction} {measure} of {name}"
  },
  "add_ingredient": "Add ingredient",
  "delete_ingredient": "Delete ingredient",
  "move_ingredient": "Move ingredient",
  "ingredient_hint": "e.g.: 100g sugar",
  "___comment3": "STEPS",
  "steps": "Steps",
  "add_step": "Add step",
  "delete_step": "Delete step",
  "move_step": "Move step",
  "___comment4": "OTHERS",
  "title_required": "Please, enter with some title",
  "type": "Type",
  "type_required": "Please, select a type",
  "serve": "Serve",
  "description": "Description",
  "peoples_serves": "Serves how many people",
  "person": {
    "person": "person",
    "people": "people"
  },
  "difficulty_level": "Difficulty",
  "difficulty_required": "Please, select a level",
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
  "___comment0": "GENERALS",
  "unknow": "unknow",
  "not_informed": "not informed",
  "undefined": "undefined",
  "save": "Save",
  "edit": "Edit",
  "delete": "Delete"
};
  static const Map<String, Map<String,dynamic>> mapLocales = {"pt": pt, "en": en};
}
