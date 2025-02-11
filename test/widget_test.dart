import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_golden_test_demo/demo_widget.dart';

import 'package:forui/forui.dart';

void main() {
  group('DemoWidget', () {
    late FContinuousSliderController controller;

    setUp(() {
      controller = FContinuousSliderController(
        allowedInteraction: FSliderInteraction.slide,
        selection: FSliderSelection(max: 0.3),
      );
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('initializes with correct value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(
            data: FThemes.zinc.light,
            child: child!,
          ),
          home: Center(
            child: DemoWidget(controller: controller),
          ),
        ),
      );

      final sliderFinder = find.byType(FSlider);
      expect(sliderFinder, findsOneWidget);

      expect(controller.selection.offset.max, 0.3);
    });

    testWidgets('drag thumb to change value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(
            data: FThemes.zinc.light,
            child: child!,
          ),
          home: Center(
            child: DemoWidget(controller: controller),
          ),
        ),
      );

      final sliderFinder = find.byType(FSlider);
      await tester.drag(sliderFinder, const Offset(100, 0));
      await tester.pumpAndSettle();

      expect(sliderFinder, findsOneWidget);
      expect(controller.selection.offset.max, greaterThan(0.3));
    });
  });
}
