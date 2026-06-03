import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_starter/core/error/failure.dart';
import 'package:flutter_mvvm_starter/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_model.dart';

/// Named record returned by [signIn].
typedef SignInResult = ({
  String token,
  String refreshToken,
  UserModel user,
});

/// Repository for all authentication operations.
///
/// Receives raw [Response] from [AuthDataSource], parses JSON,
/// and returns typed domain objects via [Either].
class AuthRepository {
  final AuthDataSource _dataSource;

  const AuthRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  // ─── Sign in ──────────────────────────────────────────────────────────────

  Future<Either<Failure, SignInResult>> signIn({
    required String username,
    required String password,
  }) async {
    final result = await _dataSource.signIn(
      username: username,
      password: password,
    );
    return result.fold(
      left,
      (response) {
        final token = response.data['token'] as String;
        final refreshToken = response.data['refreshToken'] as String;
        final user = UserModel.fromJson(
            response.data['user'] as Map<String, dynamic>);
        return right((
          token: token,
          refreshToken: refreshToken,
          user: user,
        ));
      },
    );
  }

  // ─── Logout ───────────────────────────────────────────────────────────────

  Future<Either<Failure, bool>> logout({
    required String refreshToken,
  }) async {
    final result = await _dataSource.logout(refreshToken: refreshToken);
    return result.fold(
      left,
      (response) => right(response.data['success'] as bool? ?? true),
    );
  }

  // ─── Change password ──────────────────────────────────────────────────────

  Future<Either<Failure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await _dataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    return result.fold(
      left,
      (response) => right(response.data['success'] as bool? ?? true),
    );
  }

  // ─── Profile ──────────────────────────────────────────────────────────────

  Future<Either<Failure, UserModel>> getProfile() async {
    final result = await _dataSource.getProfile();
    return result.fold(
      left,
      (response) =>
          right(UserModel.fromJson(response.data as Map<String, dynamic>)),
    );
  }

  Future<Either<Failure, UserModel>> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    final result = await _dataSource.updateProfile(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
    return result.fold(
      left,
      (response) =>
          right(UserModel.fromJson(response.data as Map<String, dynamic>)),
    );
  }

  // ─── Helper: serialize user for SessionManager ────────────────────────────

  /// Converts a [UserModel] to a JSON string for [SessionManager.setUserJson].
  static String userToJson(UserModel user) => jsonEncode(user.toJson());

  /// Parses a JSON string from [SessionManager.getUserJson] to [UserModel].
  /// Returns null if the string is null or malformed.
  static UserModel? userFromJson(String? json) {
    if (json == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}
