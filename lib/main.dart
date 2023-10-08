import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/IoC/ioc.dart' as ioc;
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
import 'package:recipe_book_app/core/services/navigation_service.dart';
import 'package:recipe_book_app/features/recipe/presentation/pages/list_recipes_page.dart';
import 'package:recipe_book_app/core/localization_generated/codegen_loader.g.dart';
import 'package:recipe_book_app/router.dart' as R;

void main() async {
  await ioc.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorObservers: [ioc.ioc<AnalyticsService>().getAnalyticsObserver()],
      navigatorKey: ioc.ioc<NavigationService>().navigatorKey,
      onGenerateRoute: R.Router.generateRoute,
      title: LocaleKeys.recipe_book,
      theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF),
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
