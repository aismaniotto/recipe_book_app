import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/identificable_text_adapater.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

void main() {
  late RecipeAdapter adapter;
  late IdentificableTextAdapter textAdapter;

  setUp(() {
    textAdapter = IdentificableTextAdapter();
    adapter = RecipeAdapter(textAdapter);
  });

  group('RecipeAdapter', () {
    test('toMap serializa todos os campos', () {
      final recipe = Recipe(
        id: 'test-id',
        title: 'Cookies',
        description: 'Easy cookies',
        type: Type.snack,
        quantityPeopleServide: 10,
        difficulty: Difficulty.medium,
        ingredientList: [IdentificableText('Flour', id: 'ing-1')],
        steps: [IdentificableText('Mix', id: 'step-1')],
        isFavorite: true,
        prepTimeMinutes: 30,
      );

      final map = adapter.toMap(recipe);

      expect(map['id'], 'test-id');
      expect(map['title'], 'Cookies');
      expect(map['description'], 'Easy cookies');
      expect(map['type'], 'Type.snack');
      expect(map['quantityPeopleServide'], 10);
      expect(map['difficulty'], 'Difficulty.medium');
      expect(map['ingredientList'], isA<List>());
      expect(map['ingredientList'].length, 1);
      expect(map['steps'], isA<List>());
      expect(map['steps'].length, 1);
      expect(map['isFavorite'], true);
      expect(map['prepTimeMinutes'], 30);
    });

    test('fromMap desserializa todos os campos', () {
      final map = {
        'id': 'test-id',
        'title': 'Cookies',
        'description': 'Easy cookies',
        'type': 'Type.snack',
        'quantityPeopleServide': 10,
        'difficulty': 'Difficulty.medium',
        'ingredientList': [
          {'id': 'ing-1', 'text': 'Flour'}
        ],
        'steps': [
          {'id': 'step-1', 'text': 'Mix'}
        ],
        'isFavorite': true,
        'prepTimeMinutes': 30,
      };

      final recipe = adapter.fromMap(map);

      expect(recipe.id, 'test-id');
      expect(recipe.title, 'Cookies');
      expect(recipe.description, 'Easy cookies');
      expect(recipe.type, Type.snack);
      expect(recipe.quantityPeopleServide, 10);
      expect(recipe.difficulty, Difficulty.medium);
      expect(recipe.ingredientList.length, 1);
      expect(recipe.ingredientList[0].text, 'Flour');
      expect(recipe.steps.length, 1);
      expect(recipe.steps[0].text, 'Mix');
      expect(recipe.isFavorite, true);
      expect(recipe.prepTimeMinutes, 30);
    });

    test('fromMap é retrocompatível sem isFavorite e prepTimeMinutes', () {
      final map = {
        'id': 'old-id',
        'title': 'Old Recipe',
        'description': null,
        'type': 'Type.meal',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
      };

      final recipe = adapter.fromMap(map);

      expect(recipe.isFavorite, false);
      expect(recipe.prepTimeMinutes, isNull);
    });

    test('fromMap com campos extras ignora gracefully', () {
      final map = {
        'id': 'extra-id',
        'title': 'Extra',
        'description': null,
        'type': 'Type.other',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
        'isFavorite': false,
        'prepTimeMinutes': null,
        'campoInexistente': 'valor qualquer',
        'outroExtra': 42,
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.title, 'Extra');
    });

    test('fromMap com listas vazias', () {
      final map = {
        'id': 'empty-lists',
        'title': 'Sem ingredientes',
        'description': null,
        'type': 'Type.other',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.ingredientList, isEmpty);
      expect(recipe.steps, isEmpty);
    });

    test('fromMap com description null', () {
      final map = {
        'id': 'null-desc',
        'title': 'Sem desc',
        'description': null,
        'type': 'Type.other',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.description, isNull);
    });

    test('fromMap com prepTimeMinutes = 0', () {
      final map = {
        'id': 'zero-prep',
        'title': 'Instantâneo',
        'description': null,
        'type': 'Type.snack',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
        'isFavorite': false,
        'prepTimeMinutes': 0,
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.prepTimeMinutes, 0);
    });

    test('toMap com isFavorite false', () {
      final recipe = Recipe(title: 'Test');
      final map = adapter.toMap(recipe);
      expect(map['isFavorite'], false);
    });

    test('round-trip com receita mínima (só defaults)', () {
      final original = Recipe();
      final restored = adapter.fromMap(adapter.toMap(original));

      expect(restored.id, original.id);
      expect(restored.title, '');
      expect(restored.description, isNull);
      expect(restored.type, Type.other);
      expect(restored.difficulty, Difficulty.easy);
      expect(restored.isFavorite, false);
      expect(restored.prepTimeMinutes, isNull);
    });

    test('round-trip preserva múltiplos ingredientes e passos', () {
      final original = Recipe(
        title: 'Completa',
        ingredientList: [
          IdentificableText('A', id: 'i1'),
          IdentificableText('B', id: 'i2'),
          IdentificableText('C', id: 'i3'),
        ],
        steps: [
          IdentificableText('Passo 1', id: 's1'),
          IdentificableText('Passo 2', id: 's2'),
        ],
      );

      final restored = adapter.fromMap(adapter.toMap(original));

      expect(restored.ingredientList.length, 3);
      expect(restored.ingredientList[0].text, 'A');
      expect(restored.ingredientList[1].text, 'B');
      expect(restored.ingredientList[2].text, 'C');
      expect(restored.steps.length, 2);
      expect(restored.steps[0].text, 'Passo 1');
      expect(restored.steps[1].text, 'Passo 2');
    });

    test('serializa todos os tipos de receita (enum Type)', () {
      for (final type in Type.values) {
        final recipe = Recipe(title: 'Test', type: type);
        final map = adapter.toMap(recipe);
        final restored = adapter.fromMap(map);
        expect(restored.type, type);
      }
    });

    test('serializa todos os níveis de dificuldade (enum Difficulty)', () {
      for (final diff in Difficulty.values) {
        final recipe = Recipe(title: 'Test', difficulty: diff);
        final map = adapter.toMap(recipe);
        final restored = adapter.fromMap(map);
        expect(restored.difficulty, diff);
      }
    });

    test('fromMap usa Type.other como fallback para tipo inválido', () {
      final map = {
        'id': 'fallback-type',
        'title': 'Teste',
        'description': null,
        'type': 'Type.invalido',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.easy',
        'ingredientList': [],
        'steps': [],
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.type, Type.other);
    });

    test('fromMap usa Difficulty.easy como fallback para dificuldade inválida', () {
      final map = {
        'id': 'fallback-diff',
        'title': 'Teste',
        'description': null,
        'type': 'Type.meal',
        'quantityPeopleServide': null,
        'difficulty': 'Difficulty.invalida',
        'ingredientList': [],
        'steps': [],
      };

      final recipe = adapter.fromMap(map);
      expect(recipe.difficulty, Difficulty.easy);
    });

    test('toMap e fromMap são inversos (round-trip)', () {
      final original = Recipe(
        title: 'Bolo',
        description: 'Delicioso',
        type: Type.dessert,
        difficulty: Difficulty.hard,
        quantityPeopleServide: 8,
        ingredientList: [
          IdentificableText('Farinha', id: 'i1'),
          IdentificableText('Açúcar', id: 'i2'),
        ],
        steps: [
          IdentificableText('Misturar', id: 's1'),
        ],
        isFavorite: true,
        prepTimeMinutes: 60,
      );

      final restored = adapter.fromMap(adapter.toMap(original));

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.description, original.description);
      expect(restored.type, original.type);
      expect(restored.difficulty, original.difficulty);
      expect(restored.quantityPeopleServide, original.quantityPeopleServide);
      expect(restored.ingredientList.length, original.ingredientList.length);
      expect(restored.steps.length, original.steps.length);
      expect(restored.isFavorite, original.isFavorite);
      expect(restored.prepTimeMinutes, original.prepTimeMinutes);
    });
  });

  group('IdentificableTextAdapter', () {
    test('toMap serializa texto e id', () {
      final text = IdentificableText('Farinha', id: 'txt-1');
      final map = textAdapter.toMap(text);

      expect(map['text'], 'Farinha');
      expect(map['id'], 'txt-1');
    });

    test('fromMap desserializa texto e id', () {
      final map = {'text': 'Açúcar', 'id': 'txt-2'};
      final text = textAdapter.fromMap(map);

      expect(text.text, 'Açúcar');
      expect(text.id, 'txt-2');
    });
  });
}
