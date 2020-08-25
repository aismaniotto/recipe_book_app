import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future createRecipe() async {
    await _analytics.logEvent(
      name: 'create recipe',
      parameters: {'some crazy parameter': 'Sayonara mão da foca!!'},
    );
  }
}
