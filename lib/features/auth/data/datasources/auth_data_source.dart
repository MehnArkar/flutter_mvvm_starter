import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_starter/core/error/failure.dart';
import 'package:flutter_mvvm_starter/core/network/api_client.dart';
import 'package:flutter_mvvm_starter/core/network/api_endpoints.dart';

/// Handles all raw HTTP calls for the auth feature.
/// Returns [Either<Failure, Response>] — parsing is done in the repository.
class AuthDataSource extends ApiClient {
  const AuthDataSource({required super.dio});

  Future<Either<Failure, Response>> signIn({
    required String username,
    required String password,
  }) =>
      requestAPI(
        () => dio.post(
          ApiEndpoints.signIn,
          data: {'username': username, 'password': password},
        ),
      );

  Future<Either<Failure, Response>> logout({
    required String refreshToken,
  }) =>
      requestAPI(
        () => dio.post(
          ApiEndpoints.logout,
          data: {'refreshToken': refreshToken},
        ),
      );

  Future<Either<Failure, Response>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) =>
      requestAPI(
        () => dio.post(
          ApiEndpoints.changePassword,
          data: {
            'currentPassword': currentPassword,
            'newPassword': newPassword,
          },
        ),
      );

  Future<Either<Failure, Response>> getProfile() =>
      requestAPI(() => dio.get(ApiEndpoints.profile));

  Future<Either<Failure, Response>> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) =>
      requestAPI(
        () => dio.patch(
          ApiEndpoints.profile,
          data: {
            if (name != null) 'name': name,
            if (email != null) 'email': email,
            if (avatarUrl != null) 'avatarUrl': avatarUrl,
          },
        ),
      );
}
