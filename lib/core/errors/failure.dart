import 'package:equatable/equatable.dart';

/// Every error the UI can see. Data sources convert raw exceptions into these.
sealed class Failure extends Equatable implements Exception {
  const Failure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
