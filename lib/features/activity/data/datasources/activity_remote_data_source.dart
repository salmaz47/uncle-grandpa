import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/activity_model.dart';

class ActivityRemoteDataSource {
  final http.Client _client;

  ActivityRemoteDataSource(this._client);

  Future<ActivityModel> fetchRandomActivity() async {
    // Step 1: Define the API URL
    final String url = 'https://bored-api.appbrewery.com/random';

    final uri = Uri.parse(url);

    // Step 2: Send HTTP GET request
    final response = await _client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    // Step 3: Check response status
    if (response.statusCode != 200) {
      throw Exception('Failed with status ${response.statusCode}');
    }

    // Step 4: Decode JSON response
    final data = jsonDecode(response.body);

    // Step 5: Validate JSON structure
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid activity response');
    }

    // Step 6: Convert JSON to ActivityModel
    return ActivityModel.fromJson(data);
  }
}
