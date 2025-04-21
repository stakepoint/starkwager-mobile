import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message, int? code})
      : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message})
      : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message})
      : super(message: message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({required String message})
      : super(message: message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required String message})
      : super(message: message);
}
