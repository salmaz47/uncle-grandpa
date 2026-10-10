
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uncle_grandpa/main.dart';

void main() {
  testWidgets('Activity Finder initial screen test', (tester) async {
    // Build the Activity Finder app
    await tester.pumpWidget(const ActivityApp());

    // Verify the app title appears
    expect(find.text('Activity Finder'), findsOneWidget);

    // Verify the main button exists
    expect(find.text('Find an Activity'), findsOneWidget);

    // Verify the button is enabled
    final button = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );

    expect(button.onPressed, isNotNull);

    // Verify loading is not active initially
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
