import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NpsService {
  static const _npsAnsweredKey = 'nps_answered';
  static const _viewCountKey = 'nps_view_count';
  static const _createCountKey = 'nps_create_count';
  static const _editCountKey = 'nps_edit_count';

  static const _viewsBeforePrompt = 7;
  static const _createsBeforePrompt = 5;
  static const _editsBeforePrompt = 3;

  final FirebaseAnalytics? _analytics;

  NpsService({this._analytics});

  Future<void> onRecipeViewed() async {
    if (await _alreadyAnswered()) return;
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_viewCountKey) ?? 0) + 1;
    await prefs.setInt(_viewCountKey, count);
  }

  Future<void> onRecipeCreated() async {
    if (await _alreadyAnswered()) return;
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_createCountKey) ?? 0) + 1;
    await prefs.setInt(_createCountKey, count);
  }

  Future<void> onRecipeEdited() async {
    if (await _alreadyAnswered()) return;
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_editCountKey) ?? 0) + 1;
    await prefs.setInt(_editCountKey, count);
  }

  Future<bool> shouldShowNps() async {
    if (await _alreadyAnswered()) return false;
    final prefs = await SharedPreferences.getInstance();
    final views = prefs.getInt(_viewCountKey) ?? 0;
    final creates = prefs.getInt(_createCountKey) ?? 0;
    final edits = prefs.getInt(_editCountKey) ?? 0;
    return views >= _viewsBeforePrompt ||
        creates >= _createsBeforePrompt ||
        edits >= _editsBeforePrompt;
  }

  Future<void> recordNps(int score, {String? feedback}) async {
    try {
      final analytics = _analytics ?? FirebaseAnalytics.instance;
      await analytics.logEvent(
        name: 'nps_response',
        parameters: {
          'score': score,
          'category': _category(score),
          if (feedback != null && feedback.isNotEmpty) 'feedback': feedback,
        },
      );
    } catch (e) {
      debugPrint('Failed to log NPS event: $e');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_npsAnsweredKey, true);
  }

  Future<bool> _alreadyAnswered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_npsAnsweredKey) ?? false;
  }

  String _category(int score) {
    if (score >= 9) return 'promoter';
    if (score >= 7) return 'passive';
    return 'detractor';
  }

  bool isPromoter(int score) => score >= 9;
}
