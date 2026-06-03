import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  /// e.g. "Tue, 03 Jun 2026"
  String toEEEddMMMyyyy() =>
      DateFormat('EEE, dd MMM yyyy').format(toLocal());

  /// e.g. "03 Jun, 2026"
  String toddMMMyyyy() =>
      DateFormat('dd MMM, yyyy').format(toLocal());

  /// e.g. "09:30 AM"
  String toHourMinuteAmPm() =>
      DateFormat('hh:mm a').format(toLocal());

  /// e.g. "2026-06-03"
  String toYYYYMMDD() =>
      DateFormat('yyyy-MM-dd').format(toLocal());
}
