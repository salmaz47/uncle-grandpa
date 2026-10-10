import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'core/theme/app_theme.dart';
import 'features/activity/data/datasources/activity_remote_data_source.dart';
import 'features/activity/data/repositories/activity_repository_impl.dart';
import 'features/activity/domain/usecases/get_random_activity.dart';
import 'features/activity/presentation/controllers/activity_controller.dart';
import 'features/activity/presentation/pages/activity_page.dart';

void main() => runApp(const ActivityApp());

class ActivityApp extends StatefulWidget {
  const ActivityApp({super.key});

  @override
  State<ActivityApp> createState() => _ActivityAppState();
}

class _ActivityAppState extends State<ActivityApp> {
  late final http.Client _client;
  late final ActivityController _controller;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    final dataSource = ActivityRemoteDataSource(_client);
    final repository = ActivityRepositoryImpl(dataSource);
    final getRandomActivity = GetRandomActivity(repository);
    _controller = ActivityController(getRandomActivity);
  }

  @override
  void dispose() {
    _controller.dispose();
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uncle Grandpa',
      theme: AppTheme.light,
      home: ActivityPage(controller: _controller),
    );
  }
}
