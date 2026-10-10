
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'features/activity/data/datasources/activity_remote_data_source.dart';
import 'features/activity/data/repositories/activity_repository_impl.dart';
import 'features/activity/domain/usecases/get_random_activity.dart';
import 'features/activity/presentation/controllers/activity_controller.dart';

void main() {
  runApp(const ActivityApp());
}

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

    // 1. Create HTTP client
    _client = http.Client();

    // 2. Create remote data source
    final dataSource = ActivityRemoteDataSource(_client);

    // 3. Create repository
    final repository = ActivityRepositoryImpl(dataSource);

    // 4. Create use case
    final getRandomActivity = GetRandomActivity(repository);

    // 5. Create controller
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
      title: 'Activity Finder',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF246B4A),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activity Finder'),
        ),
        body: Center(
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, child) {
              if (_controller.isLoading) {
                return const CircularProgressIndicator();
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_controller.activity != null)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        _controller.activity!.activity,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  if (_controller.error != null)
                    Text(_controller.error!),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _controller.findActivity,
                    child: const Text('Find an Activity'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
