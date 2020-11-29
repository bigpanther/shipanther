// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipanther/main_common.dart';

void main() {
  testWidgets('Expect sign in on start', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShipantherApp("https://dummy.shipanther.ca"));

    expect(find.byIcon(Icons.verified_user), findsOneWidget);
    expect(find.byIcon(Icons.person_add), findsNothing);
    var button = find.byType(TextButton);
    expect(button, findsOneWidget);
  });
}
