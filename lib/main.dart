import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/crashlytics_service.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/core/theme/app_theme.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/list_recipes_page.dart';
import 'package:recipe_book_app/features/settings/presentation/stores/settings_store.dart';
import 'package:recipe_book_app/core/localization_generated/codegen_loader.g.dart';
import 'package:recipe_book_app/router.dart' as app_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CrashlyticsService.init();
  await ioc.init();
  await ioc.ioc<SettingsStore>().loadSettings();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('pt'), Locale('es'), Locale('it'), Locale('de'), Locale('ru')],
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
    CrashlyticsService.setContext(locale: context.locale.toString());
    final settingsStore = ioc.ioc<SettingsStore>();

    return Observer(
      builder: (_) => MaterialApp(
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
        navigatorKey: ioc.ioc<NavigationService>().navigatorKey,
        onGenerateRoute: app_router.Router.generateRoute,
        title: LocaleKeys.recipe_book.tr(),
        theme: AppTheme.light(primaryColor: settingsStore.themeColor, fontScale: settingsStore.fontScale.value),
        darkTheme: AppTheme.dark(primaryColor: settingsStore.themeColor, fontScale: settingsStore.fontScale.value),
        themeMode: settingsStore.themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: ListRecipesPage(
          store: ioc.ioc(),
          navigationService: ioc.ioc(),
        ),
      ),
    );
  }
}
