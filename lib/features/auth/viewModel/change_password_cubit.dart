import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';

/// Handles the change-password flow.
///
/// Used in two contexts:
/// 1. Voluntary change from a settings/profile screen.
/// 2. Forced change on first login when [mustChangePassword] = true.
class ChangePasswordCubit extends Cubit<DefaultState<bool>> {
  final AuthRepository _authRepository;

  ChangePasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const DefaultState.init());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const DefaultState.loading());

    final result = await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(DefaultState.fail(failure)),
      (success) => emit(DefaultState.success(success)),
    );
  }

  void reset() => emit(const DefaultState.init());
}
