import 'package:dio/dio.dart';

import 'failure.dart';

/// Turns a [DioException] into a [Failure]. Call this inside remote sources
/// so Dio types never leave the data layer.
Failure mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      return _fromStatus(
        e.response?.statusCode,
        _serverMessage(e.response?.data),
      );
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return UnknownFailure(e.message);
  }
}

Failure _fromStatus(int? status, String? message) {
  if (status == 401 || status == 403) return UnauthorizedFailure(message);
  if (status == 404) return NotFoundFailure(message);
  if (status != null && status >= 500) return ServerFailure(message);
  return UnknownFailure(message);
}

String? _serverMessage(Object? data) {
  if (data is Map<String, dynamic>) {
    final message = data['message'];
    if (message is String) return message;
  }
  return null;
}
