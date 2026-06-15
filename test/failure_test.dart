import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book_app/core/error/failure.dart';

void main() {
  group('DatabaseFailure', () {
    test('armazena mensagem e stackTrace', () {
      final failure = DatabaseFailure(
        message: 'Erro no banco',
        stackTrace: StackTrace.current,
      );

      expect(failure.message, 'Erro no banco');
      expect(failure.stackTrace, isNotNull);
    });

    test('fromError cria a partir de exceção', () {
      try {
        throw Exception('db error');
      } catch (e, s) {
        final failure = DatabaseFailure.fromError(e, s);
        expect(failure.message, contains('db error'));
        expect(failure.stackTrace, isNotNull);
      }
    });

    test('toString inclui tipo e mensagem', () {
      final failure = DatabaseFailure(message: 'teste');
      expect(failure.toString(), 'DatabaseFailure: teste');
    });
  });

  group('NotFoundFailure', () {
    test('armazena mensagem', () {
      final failure = NotFoundFailure(message: 'Receita não encontrada');
      expect(failure.message, 'Receita não encontrada');
    });
  });

  group('Failure data', () {
    test('addData armazena dados de contexto', () {
      final failure = DatabaseFailure(message: 'erro');
      failure.addData('recipeId', '123');
      failure.addData('operation', 'insert');

      expect(failure.data['recipeId'], '123');
      expect(failure.data['operation'], 'insert');
    });

    test('data retorna mapa não modificável', () {
      final failure = DatabaseFailure(message: 'erro');
      failure.addData('key', 'value');

      expect(() => failure.data['new'] = 'value', throwsUnsupportedError);
    });

    test('data vazio por padrão', () {
      final failure = DatabaseFailure(message: 'erro');
      expect(failure.data, isEmpty);
    });
  });
}
