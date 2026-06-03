import 'package:form_field_validator/form_field_validator.dart';

class FormValidator {
  FormValidator._();

  static MultiValidator email() => MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'Invalid email address'),
      ]);

  static EmailValidator emailOptional() =>
      EmailValidator(errorText: 'Invalid email address');

  static RequiredValidator required([String? label]) =>
      RequiredValidator(errorText: '${label ?? 'This field'} is required');

  static MultiValidator minLength(int min, [String? label]) => MultiValidator([
        RequiredValidator(errorText: '${label ?? 'This field'} is required'),
        MinLengthValidator(min,
            errorText: 'At least $min characters required'),
      ]);

  /// Returns an error string if the two values don't match, null otherwise.
  /// Use directly as [TextFormField.validator].
  static String? confirmMatch(String value, String other) =>
      MatchValidator(errorText: 'Values do not match')
          .validateMatch(value, other);
}
