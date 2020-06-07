// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecipeStore on _RecipeStore, Store {
  final _$titleAtom = Atom(name: '_RecipeStore.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_RecipeStore.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$typeAtom = Atom(name: '_RecipeStore.type');

  @override
  Type get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(Type value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$quantityPeopleServideAtom =
      Atom(name: '_RecipeStore.quantityPeopleServide');

  @override
  int get quantityPeopleServide {
    _$quantityPeopleServideAtom.reportRead();
    return super.quantityPeopleServide;
  }

  @override
  set quantityPeopleServide(int value) {
    _$quantityPeopleServideAtom.reportWrite(value, super.quantityPeopleServide,
        () {
      super.quantityPeopleServide = value;
    });
  }

  final _$difficultyAtom = Atom(name: '_RecipeStore.difficulty');

  @override
  Difficulty get difficulty {
    _$difficultyAtom.reportRead();
    return super.difficulty;
  }

  @override
  set difficulty(Difficulty value) {
    _$difficultyAtom.reportWrite(value, super.difficulty, () {
      super.difficulty = value;
    });
  }

  final _$ingredientListAtom = Atom(name: '_RecipeStore.ingredientList');

  @override
  List<Ingredient> get ingredientList {
    _$ingredientListAtom.reportRead();
    return super.ingredientList;
  }

  @override
  set ingredientList(List<Ingredient> value) {
    _$ingredientListAtom.reportWrite(value, super.ingredientList, () {
      super.ingredientList = value;
    });
  }

  final _$stepsAtom = Atom(name: '_RecipeStore.steps');

  @override
  List<String> get steps {
    _$stepsAtom.reportRead();
    return super.steps;
  }

  @override
  set steps(List<String> value) {
    _$stepsAtom.reportWrite(value, super.steps, () {
      super.steps = value;
    });
  }

  final _$saveRecipeAsyncAction = AsyncAction('_RecipeStore.saveRecipe');

  @override
  Future saveRecipe() {
    return _$saveRecipeAsyncAction.run(() => super.saveRecipe());
  }

  final _$_RecipeStoreActionController = ActionController(name: '_RecipeStore');

  @override
  dynamic changeTitle(String newTitle) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeTitle');
    try {
      return super.changeTitle(newTitle);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDescription(String newDescription) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeDescription');
    try {
      return super.changeDescription(newDescription);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeType(Type newType) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeType');
    try {
      return super.changeType(newType);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeQuantityPeopleServide(int newQuantityPeopleServide) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeQuantityPeopleServide');
    try {
      return super.changeQuantityPeopleServide(newQuantityPeopleServide);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
type: ${type},
quantityPeopleServide: ${quantityPeopleServide},
difficulty: ${difficulty},
ingredientList: ${ingredientList},
steps: ${steps}
    ''';
  }
}
