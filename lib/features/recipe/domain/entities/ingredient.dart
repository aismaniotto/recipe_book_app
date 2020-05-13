import 'dart:ffi';

class Ingredient {
  String name;
  double quantity;
  String measure; //TODO:enum or new class

  Ingredient(this.name, this.quantity, this.measure);
}
