
import 'package:flutter/foundation.dart';

import '../../domain/entities/activity.dart';
import '../../domain/usecases/get_random_activity.dart';

class ActivityController extends ChangeNotifier {
  final GetRandomActivity _getRandomActivity;

  ActivityController(this._getRandomActivity);

  bool isLoading = false;
  Activity? activity;
  String? error;

  Future<void> findActivity() async {
    if (isLoading) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _getRandomActivity();
      activity = result;
    } catch (e) {
      error = "Couldn't find an activity. Please try again.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
