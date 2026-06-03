import 'package:freezed_annotation/freezed_annotation.dart';

/// User roles — replace/extend with the roles your API uses.
/// The [value] is the string sent/received from the API.
enum UserRole {
  @JsonValue('ADMIN')
  admin(label: 'Admin', value: 'ADMIN'),

  @JsonValue('MANAGER')
  manager(label: 'Manager', value: 'MANAGER'),

  @JsonValue('STAFF')
  staff(label: 'Staff', value: 'STAFF');

  final String label;
  final String value;

  const UserRole({required this.label, required this.value});
}
