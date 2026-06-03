// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  avatarUrl: json['avatarUrl'] as String?,
  mustChangePassword: json['mustChangePassword'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'avatarUrl': instance.avatarUrl,
      'mustChangePassword': instance.mustChangePassword,
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'ADMIN',
  UserRole.manager: 'MANAGER',
  UserRole.staff: 'STAFF',
};
