import 'package:bratacha/extensions/test_window_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('simulateSize', (tester) async {
    final window = tester.binding.window;
    expect(window.physicalSize, Size(2400, 1800));
    expect(window.devicePixelRatio, 3.0);

    window.simulateSize(Size(540, 1170));

    expect(window.physicalSize, Size(540, 1170));
    expect(window.devicePixelRatio, 1.0);

    window.clearPhysicalSizeTestValue();
    window.clearDevicePixelRatioTestValue();

    expect(window.physicalSize, Size(2400, 1800));
    expect(window.devicePixelRatio, 3.0);
  });
}
