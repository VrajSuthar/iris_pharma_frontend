import 'package:flutter_test/flutter_test.dart';
import 'package:irispharma/core/responsive/breakpoints.dart';

void main() {
  test('maps width to screen size', () {
    expect(Breakpoints.fromWidth(390), ScreenSize.mobile);
    expect(Breakpoints.fromWidth(600), ScreenSize.tablet);
    expect(Breakpoints.fromWidth(1024), ScreenSize.desktop);
  });
}
