/// Sealed failure hierarchy used across all layers.
/// Repository methods return Either<Failure, T>.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// API returned an error response (4xx / 5xx).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Device has no connectivity or request timed out.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Unexpected Dart/Flutter exception (e.g. JSON parse error).
class SystemFailure extends Failure {
  const SystemFailure(super.message);
}
