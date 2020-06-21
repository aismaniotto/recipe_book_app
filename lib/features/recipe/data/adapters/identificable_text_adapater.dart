import 'package:recipe_book_app/core/adapters/adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';

class IdentificableTextAdapter extends Adapter<IdentificableText> {
  @override
  IdentificableText fromMap(Map<String, dynamic> map) {
    return IdentificableText(map['text'], id: map['id']);
  }

  @override
  Map<String, dynamic> toMap(IdentificableText text) {
    return {
      'text': text.text,
      'id': text.id,
    };
  }
}
