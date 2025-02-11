import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class DemoWidget extends StatelessWidget {
  final FContinuousSliderController controller;

  const DemoWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FSlider(
      controller: controller,
      label: const Text('Volume'),
      marks: const [
        FSliderMark(value: 0, label: Text('0%')),
        FSliderMark(value: 0.5),
        FSliderMark(value: 1, label: Text('100%')),
      ],
    );
  }
}
