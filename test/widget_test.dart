import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:my_portfilio/main.dart';

void main() {
  testWidgets('Portfolio smoke test', (WidgetTester tester) async {
    // Set screen size to a standard desktop resolution to prevent layout overflow in headless test runs
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;

    // Reset screen size after test run
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Disable VisibilityDetector update interval to make it trigger synchronously in tests
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );

    // Verify that our portfolio loads and displays the developer name
    expect(find.text('Pulkit Tyagi'), findsAtLeast(1));

    // Pump a fixed duration to settle transitions and visibility triggers
    await tester.pump(const Duration(seconds: 1));
  });
}
