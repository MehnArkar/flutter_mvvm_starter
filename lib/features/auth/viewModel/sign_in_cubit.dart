import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_model.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';

/// Demo sign-in flow — persists a stub session on success.
class SignInCubit extends Cubit<DefaultState<UserModel>> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager;

  SignInCubit({
    required AuthRepository authRepository,
    required SessionManager sessionManager,
  })  : _authRepository = authRepository,
        _sessionManager = sessionManager,
        super(const DefaultState.init());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const DefaultState.loading());

    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(DefaultState.fail(failure)),
      (data) async {
        await _saveSession(data.token, data.refreshToken, data.user);
        emit(DefaultState.success(data.user));
      },
    );
  }

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
  }
}
