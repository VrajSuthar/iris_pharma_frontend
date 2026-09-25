import 'package:dio/dio.dart';

import '../../storage/token_storage.dart';

/// Adds the access token to every request that has one.
/// Refresh-on-401 is added with the auth feature.
class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this._tokens);

  final TokenStorage _tokens;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokens.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
