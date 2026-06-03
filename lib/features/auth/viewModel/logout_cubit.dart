import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';

/// Handles the logout flow.
///
/// Always clears the local session regardless of API response,
/// so the user is never stuck in a logged-in state due to a network error.
class LogoutCubit extends Cubit<DefaultState<bool>> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager;

  LogoutCubit({
    required AuthRepository authRepository,
    required SessionManager sessionManager,
  })  : _authRepository = authRepository,
        _sessionManager = sessionManager,
        super(const DefaultState.init());

  Future<void> logout() async {
    emit(const DefaultState.loading());

    final refreshToken = await _sessionManager.getRefreshToken();

    if (refreshToken == null) {
      // No refresh token — just clear local state
      await _sessionManager.clearSession();
      emit(const DefaultState.success(true));
      return;
    }

    final result = await _authRepository.logout(refreshToken: refreshToken);

    // Clear session regardless of API outcome
    await _sessionManager.clearSession();

    result.fold(
      // API failed but session is cleared — treat as successful logout
      (_) => emit(const DefaultState.success(true)),
      (success) => emit(DefaultState.success(success)),
    );
  }
}
