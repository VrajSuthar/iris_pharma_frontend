import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'log_tag.dart';

enum LogLevel {
  debug(500, 'DEBUG'),
  info(800, 'INFO '),
  warning(900, 'WARN '),
  error(1000, 'ERROR');

  const LogLevel(this.value, this.label);

  final int value;
  final String label;
}

/// The one logger for the whole app. Prints only in debug builds.
///
/// Every line looks the same:
/// `[tag] 14:03:22.451 INFO  message`
///
/// In a feature, make one scoped logger and reuse it:
/// ```dart
/// final _log = AppLog.scope(LogTag.cart);
/// _log.i('load cart');
/// _log.e('load cart failed', error: e, stackTrace: st);
/// ```
abstract final class AppLog {
  /// Lines below this level are dropped.
  static LogLevel minLevel = LogLevel.debug;

  static ScopedLog scope(String tag) => ScopedLog(tag);

  static void d(String message, {String tag = LogTag.app}) =>
      _log(LogLevel.debug, tag, message);

  static void i(String message, {String tag = LogTag.app}) =>
      _log(LogLevel.info, tag, message);

  static void w(String message, {String tag = LogTag.app}) =>
      _log(LogLevel.warning, tag, message);

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = LogTag.app,
  }) =>
      _log(LogLevel.error, tag, message, error: error, stackTrace: stackTrace);

  /// Shortens long values so one log line stays readable.
  static String short(Object? value, [int max = 200]) {
    final text = '$value';
    return text.length <= max ? text : '${text.substring(0, max)}…';
  }

  /// The text after the `[tag]`: `HH:mm:ss.mmm LEVEL message`.
  @visibleForTesting
  static String format(LogLevel level, String message, DateTime time) {
    String two(int n) => n.toString().padLeft(2, '0');
    final ms = time.millisecond.toString().padLeft(3, '0');
    final stamp =
        '${two(time.hour)}:${two(time.minute)}:${two(time.second)}.$ms';
    return '$stamp ${level.label} $message';
  }

  static void _log(
    LogLevel level,
    String tag,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode || level.value < minLevel.value) return;
    developer.log(
      format(level, message, DateTime.now()),
      name: tag,
      level: level.value,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

/// [AppLog] with the tag already filled in.
class ScopedLog {
  const ScopedLog(this.tag);

  final String tag;

  void d(String message) => AppLog.d(message, tag: tag);

  void i(String message) => AppLog.i(message, tag: tag);

  void w(String message) => AppLog.w(message, tag: tag);

  void e(String message, {Object? error, StackTrace? stackTrace}) =>
      AppLog.e(message, error: error, stackTrace: stackTrace, tag: tag);
}
