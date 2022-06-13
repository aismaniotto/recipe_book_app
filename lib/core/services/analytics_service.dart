import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future createRecipe() async {
    await _analytics.logEvent(
      name: 'create recipe',
      parameters: {'some crazy parameter': 'Sayonara mão da foca!!'},
    );
  }
}
