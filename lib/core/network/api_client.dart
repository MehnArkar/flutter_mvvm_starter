import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_starter/core/error/failure.dart';

/// Typedef for the request callback passed to [ApiClient.requestAPI].
typedef ApiRequest = Future<Response> Function();

/// Abstract base class for all feature-level DataSources.
///
/// Each DataSource extends this class and receives a [Dio] instance
/// through the constructor (injected by GetIt).
///
/// ```dart
/// class AuthDataSource extends ApiClient {
///   AuthDataSource({required super.dio});
///
///   Future<Either<Failure, Response>> signIn(...) =>
///       requestAPI(() => dio.post(ApiEndpoints.signIn, data: {...}));
/// }
/// ```
abstract class ApiClient {
  final Dio dio;

  const ApiClient({required this.dio});

  // ─── Error mapping ────────────────────────────────────────────────────────

  Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection.');

      case DioExceptionType.badResponse:
        try {
          final statusCode = error.response?.statusCode;
          final message =
              error.response?.data['message'] ?? 'Unknown error occurred';

          switch (statusCode) {
            case 400:
              return ServerFailure('Bad request: $message');
            case 401:
              return ServerFailure('Unauthorized: $message');
            case 403:
              return ServerFailure('Forbidden: $message');
            case 404:
              return ServerFailure('Not found: $message');
            case 422:
              return ServerFailure('Validation error: $message');
            case 500:
              return const ServerFailure('Internal server error.');
            default:
              return ServerFailure('Server error ($statusCode): $message');
          }
        } catch (_) {
          return const ServerFailure('An unexpected server error occurred.');
        }

      default:
        return ServerFailure(error.message ?? 'Unknown error occurred');
    }
  }

  // ─── Request wrapper ──────────────────────────────────────────────────────

  /// Wraps a Dio call in error handling.
  ///
  /// Returns [Right<Response>] on success, [Left<Failure>] on any error.
  Future<Either<Failure, Response>> requestAPI(ApiRequest request) async {
    try {
      final response = await request();
      return right(response);
    } on DioException catch (e) {
      return left(handleDioError(e));
    } catch (e) {
      return left(SystemFailure(e.toString()));
    }
  }
}
