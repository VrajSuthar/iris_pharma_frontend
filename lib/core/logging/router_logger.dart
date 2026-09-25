import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_log.dart';
import 'log_tag.dart';

/// Logs each page change of [router] in the standard log format.
/// Call once where the router is created; it stops when [ref] is disposed.
void logRouterChanges(GoRouter router, Ref ref) {
  final log = AppLog.scope(LogTag.router);
  String? last;

  void onChange() {
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    if (location == last) return;
    last = location;
    log.i('→ $location');
  }

  router.routerDelegate.addListener(onChange);
  ref.onDispose(() => router.routerDelegate.removeListener(onChange));
}
