import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_role.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

/// The authenticated user returned by sign-in / refresh-token endpoints.
///
/// Extend this with extra fields your API returns (e.g. avatar, department).
/// Run `dart run build_runner build` after any change.
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    String? email,
    required UserRole role,
    String? avatarUrl,
    @JsonKey(defaultValue: false) required bool mustChangePassword,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
