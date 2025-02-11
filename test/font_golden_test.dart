import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_golden_test_demo/demo_widget.dart';

import 'package:forui/forui.dart';

void main() {
  group('initializes with correct value matches golden file with fonts', () {
    late FContinuousSliderController controller;

    setUp(() async {
      final fontLoader = FontLoader('packages/forui/Inter');

      final directory = Directory('assets/fonts/inter/');
      for (final file in directory.listSync().whereType<File>().where((e) => e.path.endsWith('.ttf'))) {
        fontLoader.addFont(rootBundle.load(file.path));
      }

      await fontLoader.load();

      controller = FContinuousSliderController(
        allowedInteraction: FSliderInteraction.slide,
        selection: FSliderSelection(max: 0.3),
      );
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('drag thumb to change value matches golden file with fonts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(
            data: FThemes.zinc.light,
            child: child!,
          ),
          home: FScaffold(
            content: Center(
              child: DemoWidget(controller: controller),
            ),
          ),
        ),
      );
      
      await expectLater(
        find.byType(DemoWidget),
        matchesGoldenFile('goldens/demo_widget_font_initial.png', version: 2),
      );
    });

    testWidgets('DemoWidget after drag matches golden file', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(
            data: FThemes.zinc.light,
            child: child!,
          ),
          home: FScaffold(
            content: Center(
              child: DemoWidget(controller: controller),
            ),
          ),
        ),
      );

      final sliderFinder = find.byType(FSlider);
      await tester.drag(sliderFinder, const Offset(300, 0));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(DemoWidget),
        matchesGoldenFile('goldens/demo_widget_font_after_drag.png'),
      );
    });
  });
}
