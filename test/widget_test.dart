import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uncle_grandpa/main.dart';

void main() {
  testWidgets('Momo initial screen displays preview without calling API', (tester) async {
    await tester.pumpWidget(const ActivityApp());
    expect(find.text('YOUR NEXT SIDE QUEST'), findsOneWidget);
    expect(find.text('PREVIEW • NO ACTIVITY YET'), findsOneWidget);
    expect(find.text('Find My Next Adventure'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
