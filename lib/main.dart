import 'package:flutter/material.dart';
import 'package:flutter_golden_test_demo/demo_widget.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const GoldenTestDemo());
}

class GoldenTestDemo extends StatefulWidget {
  const GoldenTestDemo({super.key});

  @override
  State<GoldenTestDemo> createState() => _GoldenTestDemoState();
}

class _GoldenTestDemoState extends State<GoldenTestDemo> {
  late final FContinuousSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = FContinuousSliderController(
      allowedInteraction: FSliderInteraction.slide,
      selection: FSliderSelection(max: 0.35),
    );
  }

  @override
  void dispose() {
    _sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => FTheme(
        data: FThemes.zinc.light,
        child: child!,
      ),
      home: FScaffold(
        header: FHeader(
          title: const Text('Golden Test Demo'),
          actions: [
            FHeaderAction(
              icon: FIcon(FAssets.icons.bird),
              onPress: () {},
            ),
          ],
        ),
        content: Center(
          child: DemoWidget(controller: _sliderController),
        ),
      ),
    );
  }
}
