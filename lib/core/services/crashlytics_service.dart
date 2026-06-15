import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_book_app/core/error/failure.dart';

class CrashlyticsService {
  static FirebaseCrashlytics get _instance => FirebaseCrashlytics.instance;

  static Future<void> init() async {
    FlutterError.onError = _instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      _instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> setContext({
    String? locale,
  }) async {
    if (locale != null) {
      await _instance.setCustomKey('locale', locale);
    }
  }

  static Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    await _instance.recordError(error, stackTrace, fatal: fatal);
  }

  static Future<void> recordFailure(Failure failure) async {
    await _instance.setCustomKey('failure_type', failure.runtimeType.toString());

    for (final entry in failure.data.entries) {
      await _instance.setCustomKey(entry.key, entry.value.toString());
    }

    await _instance.recordError(
      failure.toString(),
      failure.stackTrace,
      fatal: false,
    );
  }
}
