import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_log.dart';
import 'log_tag.dart';

/// Logs every provider being created, changed, failing or disposed.
/// Pass to `ProviderScope(observers: [...])`.
base class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  String _name(ProviderObserverContext context) =>
      context.provider.name ?? '${context.provider.runtimeType}';

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    AppLog.d(
      '+ ${_name(context)} = ${AppLog.short(value)}',
      tag: LogTag.riverpod,
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    AppLog.d(
      '~ ${_name(context)}: ${AppLog.short(previousValue, 100)} → '
      '${AppLog.short(newValue, 100)}',
      tag: LogTag.riverpod,
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    AppLog.e(
      '! ${_name(context)} failed',
      error: error,
      stackTrace: stackTrace,
      tag: LogTag.riverpod,
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    AppLog.d('- ${_name(context)}', tag: LogTag.riverpod);
  }
}
