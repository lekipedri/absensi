import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getFormattedTime() {
    final now = DateTime.now();
    return DateFormat("dd-MM-yyyy HH:mm").format(now);
  }
}
