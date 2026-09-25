import 'package:flutter_test/flutter_test.dart';
import 'package:irispharma/core/logging/app_log.dart';

void main() {
  test('formats a line as time, level, message', () {
    final line = AppLog.format(
      LogLevel.info,
      'load cart',
      DateTime(2026, 9, 25, 14, 3, 2, 45),
    );
    expect(line, '14:03:02.045 INFO  load cart');
  });

  test('keeps every level label the same width', () {
    final widths = LogLevel.values.map((l) => l.label.length).toSet();
    expect(widths, {5});
  });

  test('short cuts long values', () {
    expect(AppLog.short('a' * 300, 10), '${'a' * 10}…');
    expect(AppLog.short('abc', 10), 'abc');
  });
}
