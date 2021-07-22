import 'package:uuid/uuid.dart';

class IdentificableText {
  String? id = Uuid().v4();
  String? text;

  IdentificableText(this.text, {this.id});

  @override
  String toString() {
    return text!;
  }
}
