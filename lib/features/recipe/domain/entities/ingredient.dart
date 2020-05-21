class Ingredient {
  final String name;
  final double quantity;
  final String measure; //TODO:enum or new class

  Ingredient(this.name, this.quantity, this.measure);

   @override
    String toString() {
        return '$quantity $measure of $name';
    }
}
