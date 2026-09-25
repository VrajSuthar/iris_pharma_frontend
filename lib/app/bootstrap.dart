import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../core/logging/app_log.dart';
import '../core/logging/log_tag.dart';
import '../core/logging/provider_logger.dart';
import '../core/storage/hive_service.dart';

/// Shared startup for both apps: storage, URL style, then run.
Future<void> bootstrap(Widget app) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  _listenForErrors();
  await HiveService.init();
  AppLog.i('Hive ready', tag: LogTag.storage);
  runApp(ProviderScope(observers: const [ProviderLogger()], child: app));
}

/// Sends uncaught Flutter and platform errors to the log.
void _listenForErrors() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppLog.e(
      'Flutter error',
      error: details.exception,
      stackTrace: details.stack,
      tag: LogTag.error,
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLog.e(
      'Uncaught error',
      error: error,
      stackTrace: stack,
      tag: LogTag.error,
    );
    return true;
  };
}
