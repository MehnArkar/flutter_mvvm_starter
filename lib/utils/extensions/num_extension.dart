import 'package:intl/intl.dart';

extension NumberFormatting on num {
  /// e.g. 1234567 → "1,234,567"
  String toMoneyFormat() => NumberFormat('#,##0', 'en_US').format(this);

  /// e.g. 1500000 → "1.5M"
  String toCompactFormat() {
    if (this >= 1e12) return '${(this / 1e12).toStringAsFixed(1)}T';
    if (this >= 1e9) return '${(this / 1e9).toStringAsFixed(1)}B';
    if (this >= 1e6) return '${(this / 1e6).toStringAsFixed(1)}M';
    if (this >= 1e3) return '${(this / 1e3).toStringAsFixed(1)}K';
    return toStringAsFixed(0);
  }
}

extension StringNumberFormatting on String {
  String toCompactFormat() {
    final value = num.tryParse(this);
    return value == null ? this : value.toCompactFormat();
  }
}
