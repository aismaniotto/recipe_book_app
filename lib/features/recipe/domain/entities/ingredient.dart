import 'dart:ffi';

class Ingredient {
  String name;
  Float quantity;
  String measure; //TODO:enum or new class

  Ingredient(this.name, this.quantity, this.measure);
}
