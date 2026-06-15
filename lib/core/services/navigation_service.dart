import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments) ??
        Future.value(null);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  void pop(bool pop) {
    navigatorKey.currentState?.pop(pop);
  }
}
