import '../entities/activity.dart';
import '../repositories/activity_repository.dart';

class GetRandomActivity {
  final ActivityRepository _repository;
  GetRandomActivity(this._repository);
  Future<Activity> call() => _repository.getRandomActivity();
}
