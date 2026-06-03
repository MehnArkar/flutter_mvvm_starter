import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/core/network/api_endpoints.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_model.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';
import 'package:dio/dio.dart';

/// Manages the sign-in flow.
///
/// On success the state will be one of:
/// - [DefaultSuccessState] — normal login; session is fully saved.
/// - [DefaultRequiresActionState] — API returned mustChangePassword=true;
///   only the access token is stored so the interceptor can call the
///   change-password endpoint. Full session is saved via [completeSignIn]
///   once the user has changed their password.
class SignInCubit extends Cubit<DefaultState<UserModel>> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager;

  // Stored during mustChangePassword flow; cleared after completeSignIn().
  String? _pendingToken;
  String? _pendingRefreshToken;
  UserModel? _pendingUser;

  SignInCubit({
    required AuthRepository authRepository,
    required SessionManager sessionManager,
  })  : _authRepository = authRepository,
        _sessionManager = sessionManager,
        super(const DefaultState.init());

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(const DefaultState.loading());

    final result = await _authRepository.signIn(
      username: username,
      password: password,
    );

    result.fold(
      (failure) => emit(DefaultState.fail(failure)),
      (data) async {
        if (data.user.mustChangePassword) {
          // Store only the access token so the auth interceptor can
          // attach it to the change-password request.
          // Refresh token + full session are saved in [completeSignIn].
          _pendingToken = data.token;
          _pendingRefreshToken = data.refreshToken;
          _pendingUser = data.user;
          await _sessionManager.setToken(data.token);
          await _registerFcmToken();
          emit(DefaultState.requiresAction(data.user));
        } else {
          await _saveSession(data.token, data.refreshToken, data.user);
          emit(DefaultState.success(data.user));
        }
      },
    );
  }

  /// Called after a successful password change to persist the full session.
  /// Pair this with [DefaultRequiresActionState] in the UI listener.
  Future<void> completeSignIn() async {
    final token = _pendingToken;
    final refreshToken = _pendingRefreshToken;
    final user = _pendingUser;
    if (token == null || refreshToken == null || user == null) return;

    _pendingToken = null;
    _pendingRefreshToken = null;
    _pendingUser = null;

    await _saveSession(token, refreshToken, user);
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  Future<void> _saveSession(
    String token,
    String refreshToken,
    UserModel user,
  ) async {
    await Future.wait([
      _sessionManager.setToken(token),
      _sessionManager.setRefreshToken(refreshToken),
      _sessionManager.setUserJson(AuthRepository.userToJson(user)),
    ]);
    await _registerFcmToken();
  }

  Future<void> _registerFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) return;

      // Replace this with your push-devices endpoint call when
      // the notification feature is added to your project.
      final dio = Dio();
      final token = await _sessionManager.getToken();
      if (token == null) return;

      await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.pushDevices}',
        data: {
          'token': fcmToken,
          'platform': Platform.isIOS ? 'IOS' : 'ANDROID',
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (_) {
      // FCM registration failure must never block the sign-in flow.
    }
  }
}
