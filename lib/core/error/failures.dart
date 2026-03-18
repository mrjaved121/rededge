sealed class Failure {
  final String message;
  final int? code;
  const Failure(this.message, {this.code});

  @override
  String toString() => 'Failure($message, code: $code)';
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection. Data saved locally.',
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local storage error']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied']);
}

class ValidationFailure extends Failure {
  final Map<String, String> fieldErrors;
  const ValidationFailure(
      super.message, {
        this.fieldErrors = const {},
      });
}

class SyncFailure extends Failure {
  final int retryCount;
  const SyncFailure(super.message, {this.retryCount = 0});
}