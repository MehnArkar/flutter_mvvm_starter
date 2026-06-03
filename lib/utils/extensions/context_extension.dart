import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Screen width shorthand.
  double get sw => MediaQuery.sizeOf(this).width;

  /// Screen height shorthand.
  double get sh => MediaQuery.sizeOf(this).height;

  /// Safe-area top padding.
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// Safe-area bottom padding.
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
}
