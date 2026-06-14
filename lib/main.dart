import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/list_recipes_page.dart';
import 'package:recipe_book_app/core/localization_generated/codegen_loader.g.dart';
import 'package:recipe_book_app/router.dart' as app_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ioc.init();
  await EasyLocalization.ensureInitialized();

  // Captura erros do Flutter (rendering, layout, etc.)
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Captura erros assíncronos não tratados
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('pt')],
        path: 'assets/lang',
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
      navigatorKey: ioc.ioc<NavigationService>().navigatorKey,
      onGenerateRoute: app_router.Router.generateRoute,
      title: LocaleKeys.recipe_book,
      theme: ThemeData(
          colorSchemeSeed: Colors.red,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          tabBarTheme: TabBarThemeData(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
          textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16.0))),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: ListRecipesPage(
        store: ioc.ioc(),
        navigationService: ioc.ioc(),
      ),
    );
  }
}
