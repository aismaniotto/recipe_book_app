import 'package:get_it/get_it.dart';
import 'package:recipe_book_app/core/services/analytics_service.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/identificable_text_adapater.dart';
import 'package:recipe_book_app/features/recipe/data/adapters/recipe_adapter.dart';
import 'package:recipe_book_app/features/recipe/data/datasources/recipe_source.dart';
import 'package:recipe_book_app/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_book_app/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/add_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/delete_recipe.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/get_all_recipes.dart';
import 'package:recipe_book_app/features/recipe/domain/usecases/update_recipe.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/filtered_recipes_store.dart';
import 'package:recipe_book_app/features/recipe/presentation/stores/recipe_store.dart';

final ioc = GetIt.instance;

Future<void> init() async {
  // Store
  ioc.registerLazySingleton(() => FilteredRecipesStore(ioc(), ioc()));
  // ioc.registerFactory(() => RecipeStore(ioc(), ioc()));
  ioc.registerFactoryParam((dynamic param1, dynamic param2) =>
      RecipeStore(ioc(), ioc(), recipe: param1));

  // Use cases
  ioc.registerLazySingleton(() => AddRecipe(repostitory: ioc()));
  ioc.registerLazySingleton(() => UpdateRecipe(repostitory: ioc()));
  ioc.registerLazySingleton(() => DeleteRecipe(repostitory: ioc()));
  ioc.registerLazySingleton(() => GetAllRecipes(repostitory: ioc()));

  // Adapters
  ioc.registerLazySingleton(() => RecipeAdapter(ioc()));
  ioc.registerLazySingleton(() => IdentificableTextAdapter());

  // Repository
  ioc.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(recipeDataSource: ioc()));

  // Data source
  ioc.registerLazySingleton<RecipeDataSource>(
      () => RecipeDataSourceImpl(recipeAdapter: ioc()));

  // Services
  ioc.registerSingleton<NavigationService>(NavigationService());
  ioc.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}
