import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/core/services/nps_service.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';

import 'helpers/fake_recipe_repository.dart';

class FakeNavigationService extends NavigationService {
  @override
  void goBack() {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RecipeStore store;
  late FakeRecipeRepository repository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<NavigationService>()) {
      getIt.registerSingleton<NavigationService>(FakeNavigationService());
    }
    if (!getIt.isRegistered<NpsService>()) {
      getIt.registerSingleton<NpsService>(NpsService());
    }
    repository = FakeRecipeRepository();
    store = RecipeStore(
      AddRecipe(repository: repository),
      UpdateRecipe(repository: repository),
    );
  });

  group('nova receita', () {
    test('inicializa com valores padrão', () {
      expect(store.title, '');
      expect(store.description, isNull);
      expect(store.type, Type.other);
      expect(store.difficulty, Difficulty.easy);
      expect(store.quantityPeopleServide, isNull);
      expect(store.prepTimeMinutes, isNull);
      expect(store.isUpdate, false);
    });

    test('inicializa com um ingrediente e um passo vazio', () {
      expect(store.ingredientList.length, 1);
      expect(store.ingredientList[0].text, '');
      expect(store.steps.length, 1);
      expect(store.steps[0].text, '');
    });

    test('changeTitle atualiza o título', () {
      store.changeTitle('Novo título');
      expect(store.title, 'Novo título');
    });

    test('changeDescription atualiza a descrição', () {
      store.changeDescription('Nova descrição');
      expect(store.description, 'Nova descrição');
    });

    test('changeType atualiza o tipo', () {
      store.changeType(Type.dessert);
      expect(store.type, Type.dessert);
    });

    test('changeType ignora null', () {
      store.changeType(Type.meal);
      store.changeType(null);
      expect(store.type, Type.meal);
    });

    test('changeQuantityPeopleServide atualiza a quantidade', () {
      store.changeQuantityPeopleServide(4);
      expect(store.quantityPeopleServide, 4);
    });

    test('changeDifficulty atualiza a dificuldade', () {
      store.changeDifficulty(Difficulty.hard);
      expect(store.difficulty, Difficulty.hard);
    });

    test('changeDifficulty ignora null', () {
      store.changeDifficulty(Difficulty.medium);
      store.changeDifficulty(null);
      expect(store.difficulty, Difficulty.medium);
    });

    test('changePrepTimeMinutes atualiza o tempo de preparo', () {
      store.changePrepTimeMinutes(30);
      expect(store.prepTimeMinutes, 30);
    });

    test('changePrepTimeMinutes aceita null', () {
      store.changePrepTimeMinutes(30);
      store.changePrepTimeMinutes(null);
      expect(store.prepTimeMinutes, isNull);
    });

    test('changePrepTimeMinutes aceita zero', () {
      store.changePrepTimeMinutes(0);
      expect(store.prepTimeMinutes, 0);
    });
  });

  group('ingredientes', () {
    test('addNewIngredient adiciona ingrediente vazio', () {
      expect(store.ingredientList.length, 1);
      store.addNewIngredient();
      expect(store.ingredientList.length, 2);
      expect(store.ingredientList[1].text, '');
    });

    test('deleteIngredient remove pelo índice', () {
      store.addNewIngredient();
      store.changeIngredient('Farinha', 0);
      store.changeIngredient('Açúcar', 1);
      store.deleteIngredient(0);
      expect(store.ingredientList.length, 1);
      expect(store.ingredientList[0].text, 'Açúcar');
    });

    test('deleteIngredient remove último item', () {
      store.deleteIngredient(0);
      expect(store.ingredientList, isEmpty);
    });

    test('changeIngredient atualiza texto pelo índice', () {
      store.changeIngredient('100g de farinha', 0);
      expect(store.ingredientList[0].text, '100g de farinha');
    });

    test('changeIngredient em lista com um único item', () {
      store.changeIngredient('Único', 0);
      expect(store.ingredientList.length, 1);
      expect(store.ingredientList[0].text, 'Único');
    });

    test('reorderIngredient move item de posição', () {
      store.addNewIngredient();
      store.addNewIngredient();
      store.changeIngredient('A', 0);
      store.changeIngredient('B', 1);
      store.changeIngredient('C', 2);

      store.reorderIngredient(0, 2);

      expect(store.ingredientList[0].text, 'B');
      expect(store.ingredientList[1].text, 'C');
      expect(store.ingredientList[2].text, 'A');
    });

    test('reorderIngredient com índices adjacentes (0→1)', () {
      store.addNewIngredient();
      store.changeIngredient('A', 0);
      store.changeIngredient('B', 1);

      store.reorderIngredient(0, 1);

      expect(store.ingredientList[0].text, 'B');
      expect(store.ingredientList[1].text, 'A');
    });

    test('reorderIngredient com índices adjacentes (1→0)', () {
      store.addNewIngredient();
      store.changeIngredient('A', 0);
      store.changeIngredient('B', 1);

      store.reorderIngredient(1, 0);

      expect(store.ingredientList[0].text, 'B');
      expect(store.ingredientList[1].text, 'A');
    });

    test('múltiplos add e delete mantém consistência', () {
      store.changeIngredient('A', 0);
      store.addNewIngredient();
      store.changeIngredient('B', 1);
      store.addNewIngredient();
      store.changeIngredient('C', 2);

      store.deleteIngredient(1); // remove B
      expect(store.ingredientList.length, 2);
      expect(store.ingredientList[0].text, 'A');
      expect(store.ingredientList[1].text, 'C');
    });
  });

  group('passos', () {
    test('addNewStep adiciona passo vazio', () {
      expect(store.steps.length, 1);
      store.addNewStep();
      expect(store.steps.length, 2);
    });

    test('deleteStep remove pelo índice', () {
      store.addNewStep();
      store.changeStep('Passo 1', 0);
      store.changeStep('Passo 2', 1);
      store.deleteStep(0);
      expect(store.steps.length, 1);
      expect(store.steps[0].text, 'Passo 2');
    });

    test('deleteStep remove último item', () {
      store.deleteStep(0);
      expect(store.steps, isEmpty);
    });

    test('changeStep atualiza texto pelo índice', () {
      store.changeStep('Misturar tudo', 0);
      expect(store.steps[0].text, 'Misturar tudo');
    });

    test('changeStep em lista com um único item', () {
      store.changeStep('Único passo', 0);
      expect(store.steps.length, 1);
      expect(store.steps[0].text, 'Único passo');
    });

    test('reorderStep move item de posição', () {
      store.addNewStep();
      store.addNewStep();
      store.changeStep('X', 0);
      store.changeStep('Y', 1);
      store.changeStep('Z', 2);

      store.reorderStep(2, 0);

      expect(store.steps[0].text, 'Z');
      expect(store.steps[1].text, 'X');
      expect(store.steps[2].text, 'Y');
    });

    test('reorderStep com índices adjacentes', () {
      store.addNewStep();
      store.changeStep('X', 0);
      store.changeStep('Y', 1);

      store.reorderStep(0, 1);

      expect(store.steps[0].text, 'Y');
      expect(store.steps[1].text, 'X');
    });
  });

  group('edição de receita existente', () {
    test('inicializa com isUpdate true e dados da receita', () {
      final existing = Recipe(
        title: 'Existente',
        description: 'Desc',
        type: Type.meal,
        difficulty: Difficulty.hard,
        quantityPeopleServide: 4,
        prepTimeMinutes: 90,
        ingredientList: [IdentificableText('Arroz')],
        steps: [IdentificableText('Cozinhar')],
        isFavorite: true,
      );

      final editStore = RecipeStore(
        AddRecipe(repository: repository),
        UpdateRecipe(repository: repository),
        recipe: existing,
      );

      expect(editStore.isUpdate, true);
      expect(editStore.title, 'Existente');
      expect(editStore.description, 'Desc');
      expect(editStore.type, Type.meal);
      expect(editStore.difficulty, Difficulty.hard);
      expect(editStore.quantityPeopleServide, 4);
      expect(editStore.prepTimeMinutes, 90);
      expect(editStore.ingredientList.length, 1);
      expect(editStore.ingredientList[0].text, 'Arroz');
      expect(editStore.steps.length, 1);
      expect(editStore.steps[0].text, 'Cozinhar');
    });

    test('permite editar campos da receita existente', () {
      final existing = Recipe(title: 'Original', type: Type.meal);
      final editStore = RecipeStore(
        AddRecipe(repository: repository),
        UpdateRecipe(repository: repository),
        recipe: existing,
      );

      editStore.changeTitle('Editado');
      editStore.changeType(Type.dessert);
      editStore.changePrepTimeMinutes(15);

      expect(editStore.title, 'Editado');
      expect(editStore.type, Type.dessert);
      expect(editStore.prepTimeMinutes, 15);
    });
  });

  group('lastFailure', () {
    test('é null por padrão', () {
      expect(store.lastFailure, isNull);
    });

    test('é preenchido quando save falha', () async {
      store.changeTitle('Teste');
      repository.shouldFail = true;
      await store.saveRecipe();

      expect(store.lastFailure, isNotNull);
    });

    test('é null quando save sucede', () async {
      store.changeTitle('Teste');
      await store.saveRecipe();

      expect(store.lastFailure, isNull);
    });
  });
}
