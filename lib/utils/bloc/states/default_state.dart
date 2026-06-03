import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_mvvm_starter/core/error/failure.dart';

part 'default_state.freezed.dart';

/// Generic sealed state for any single-result Cubit.
///
/// ```dart
/// class MyCubit extends Cubit<DefaultState<MyModel>> {
///   MyCubit() : super(const DefaultState.init());
/// }
/// ```
///
/// States:
///   • init            — not yet triggered
///   • loading         — request in flight
///   • success(data)   — request succeeded
///   • fail(failure)   — request failed
///   • requiresAction(data) — success but UI must take a follow-up action
///                            (e.g. mustChangePassword after sign-in)
@freezed
sealed class DefaultState<T> with _$DefaultState<T> {
  const factory DefaultState.init() = DefaultInitState;
  const factory DefaultState.loading() = DefaultLoadingState;
  const factory DefaultState.success(T data) = DefaultSuccessState;
  const factory DefaultState.fail(Failure failure) = DefaultFailState;
  const factory DefaultState.requiresAction(T data) = DefaultRequiresActionState;
}
