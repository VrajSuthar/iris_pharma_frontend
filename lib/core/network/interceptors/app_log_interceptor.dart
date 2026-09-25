import 'package:dio/dio.dart';

import '../../logging/app_log.dart';
import '../../logging/log_tag.dart';
import '../api_endpoints.dart';

/// Logs each request, response and error. Auth calls never log their bodies
/// (passwords, tokens), and the Authorization header is never logged.
class AppLogInterceptor extends Interceptor {
  const AppLogInterceptor();

  static const _startKey = 'log_started_at';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startKey] = DateTime.now().millisecondsSinceEpoch;
    final body = _isSensitive(options) ? null : options.data;
    AppLog.i(
      '→ ${options.method} ${options.uri}'
      '${body == null ? '' : '\n  body: ${AppLog.short(body, 500)}'}',
      tag: LogTag.http,
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    final body = _isSensitive(options) ? null : response.data;
    AppLog.i(
      '← ${response.statusCode} ${options.method} ${options.uri} '
      '(${_elapsed(options)}ms)'
      '${body == null ? '' : '\n  body: ${AppLog.short(body, 500)}'}',
      tag: LogTag.http,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    AppLog.e(
      '✗ ${err.response?.statusCode ?? err.type.name} '
      '${options.method} ${options.uri} (${_elapsed(options)}ms)',
      error: err.message,
      tag: LogTag.http,
    );
    handler.next(err);
  }

  bool _isSensitive(RequestOptions options) =>
      options.path.startsWith(ApiEndpoints.login) ||
      options.path.startsWith(ApiEndpoints.register) ||
      options.path.startsWith(ApiEndpoints.refresh);

  int _elapsed(RequestOptions options) {
    final started = options.extra[_startKey] as int?;
    return started == null
        ? 0
        : DateTime.now().millisecondsSinceEpoch - started;
  }
}
