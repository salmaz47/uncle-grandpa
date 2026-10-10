import 'package:uncle_grandpa/features/activity/domain/entities/activity.dart';

abstract class ActivityRepository {
  Future<Activity> getRandomActivity();
}
