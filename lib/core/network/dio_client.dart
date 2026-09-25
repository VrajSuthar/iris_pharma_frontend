import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_env.dart';
import '../storage/token_storage.dart';
import 'interceptors/app_log_interceptor.dart';
import 'interceptors/auth_interceptor.dart';

part 'dio_client.g.dart';

/// The one shared [Dio] instance. Only remote sources use it.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      baseUrl: AppEnv.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  client.interceptors.add(AuthInterceptor(ref.watch(tokenStorageProvider)));
  client.interceptors.add(const AppLogInterceptor());
  return client;
}
