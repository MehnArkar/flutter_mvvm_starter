import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_mvvm_starter/core/error/failure.dart';

part 'pagination_state.freezed.dart';

/// Holds the current page data for paginated list screens.
@freezed
abstract class PaginationData<T> with _$PaginationData<T> {
  const factory PaginationData({
    required T data,
    @Default(0) int currentPage,
    @Default(true) bool hasMorePage,
    @Default(false) bool isLoadingMore,
  }) = _PaginationData;
}

/// Sealed state for Cubits that drive paginated list screens.
@freezed
sealed class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.init() = PaginationInitState;
  const factory PaginationState.loading() = PaginationLoadingState;
  const factory PaginationState.success(PaginationData<T> paginationData) =
      PaginationSuccessState;
  const factory PaginationState.fail(Failure failure) = PaginationFailState;
}
