import '../../domain/entities/activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_remote_data_source.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource _service;

  ActivityRepositoryImpl(this._service);

  @override
  Future<Activity> getRandomActivity() async {
    // Step 1: Fetch activity from remote data source
    final model = await _service.fetchRandomActivity();

    // Step 2: Convert ActivityModel to Activity entity
    return model.toEntity();
  }
}
