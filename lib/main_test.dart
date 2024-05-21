import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:optimaizationmvp/main.dart';
import 'package:optimaizationmvp/src/core/bindings/initial_binding.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/views/post_list_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('App initializes with PostListScreen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the PostListScreen is displayed.
    expect(find.byType(PostListScreen), findsOneWidget);
  });

  testWidgets('App uses InitialBinding', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the InitialBinding is used.
    final binding = Get.find<InitialBinding>();
    expect(binding, isNotNull);
  });
}
