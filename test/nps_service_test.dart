import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_book_app/core/services/nps_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late NpsService npsService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    npsService = NpsService();
  });

  group('shouldShowNps', () {
    test('retorna false quando nenhum gatilho foi atingido', () async {
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('retorna false após o usuário já ter respondido', () async {
      for (var i = 0; i < 5; i++) {
        await npsService.onRecipeCreated();
      }
      await npsService.recordNps(8);
      expect(await npsService.shouldShowNps(), isFalse);
    });
  });

  group('gatilho: criar receitas (5)', () {
    test('retorna false antes de atingir o limite', () async {
      for (var i = 0; i < 4; i++) {
        await npsService.onRecipeCreated();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('retorna true ao atingir o limite', () async {
      for (var i = 0; i < 5; i++) {
        await npsService.onRecipeCreated();
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });
  });

  group('gatilho: visualizar receitas (7)', () {
    test('retorna false antes de atingir o limite', () async {
      for (var i = 0; i < 6; i++) {
        await npsService.onRecipeViewed();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('retorna true ao atingir o limite', () async {
      for (var i = 0; i < 7; i++) {
        await npsService.onRecipeViewed();
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });
  });

  group('gatilho: editar receitas (3)', () {
    test('retorna false antes de atingir o limite', () async {
      for (var i = 0; i < 2; i++) {
        await npsService.onRecipeEdited();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('retorna true ao atingir o limite', () async {
      for (var i = 0; i < 3; i++) {
        await npsService.onRecipeEdited();
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });
  });

  group('o que acontecer primeiro', () {
    test('visualizações atingem primeiro', () async {
      await npsService.onRecipeCreated(); // 1/5
      await npsService.onRecipeEdited(); // 1/3
      for (var i = 0; i < 7; i++) {
        await npsService.onRecipeViewed(); // 7/7
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });

    test('edições atingem primeiro', () async {
      await npsService.onRecipeCreated(); // 1/5
      await npsService.onRecipeViewed(); // 1/7
      for (var i = 0; i < 3; i++) {
        await npsService.onRecipeEdited(); // 3/3
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });

    test('criações atingem primeiro', () async {
      await npsService.onRecipeViewed(); // 1/7
      await npsService.onRecipeEdited(); // 1/3
      for (var i = 0; i < 5; i++) {
        await npsService.onRecipeCreated(); // 5/5
      }
      expect(await npsService.shouldShowNps(), isTrue);
    });
  });

  group('não incrementa após responder', () {
    test('onRecipeCreated não incrementa', () async {
      await npsService.recordNps(8);
      for (var i = 0; i < 10; i++) {
        await npsService.onRecipeCreated();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('onRecipeViewed não incrementa', () async {
      await npsService.recordNps(8);
      for (var i = 0; i < 10; i++) {
        await npsService.onRecipeViewed();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });

    test('onRecipeEdited não incrementa', () async {
      await npsService.recordNps(8);
      for (var i = 0; i < 10; i++) {
        await npsService.onRecipeEdited();
      }
      expect(await npsService.shouldShowNps(), isFalse);
    });
  });

  group('recordNps', () {
    test('persiste entre instâncias', () async {
      await npsService.recordNps(9);
      final newService = NpsService();
      expect(await newService.shouldShowNps(), isFalse);
    });
  });

  group('isPromoter', () {
    test('score 10 é promotor', () {
      expect(npsService.isPromoter(10), isTrue);
    });

    test('score 9 é promotor', () {
      expect(npsService.isPromoter(9), isTrue);
    });

    test('score 8 não é promotor', () {
      expect(npsService.isPromoter(8), isFalse);
    });

    test('score 0 não é promotor', () {
      expect(npsService.isPromoter(0), isFalse);
    });
  });
}
