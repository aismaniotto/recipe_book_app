// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecipeStore on _RecipeStore, Store {
  final _$saveRecipeAsyncAction = AsyncAction('_RecipeStore.saveRecipe');

  @override
  Future<dynamic> saveRecipe() {
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
  dynamic addNewIngredient() {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.addNewIngredient');
    try {
      return super.addNewIngredient();
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteIngredient(int index) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.deleteIngredient');
    try {
      return super.deleteIngredient(index);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIngredient(String newIngredient, int index) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeIngredient');
    try {
      return super.changeIngredient(newIngredient, index);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reorderIngredient(int oldIndex, int newIndex) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.reorderIngredient');
    try {
      return super.reorderIngredient(oldIndex, newIndex);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addNewStep() {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.addNewStep');
    try {
      return super.addNewStep();
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteStep(int index) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.deleteStep');
    try {
      return super.deleteStep(index);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeStep(String newStep, int index) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.changeStep');
    try {
      return super.changeStep(newStep, index);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reorderStep(int oldIndex, int newIndex) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.reorderStep');
    try {
      return super.reorderStep(oldIndex, newIndex);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
