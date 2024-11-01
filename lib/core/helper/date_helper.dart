import 'package:intl/intl.dart';

class DateHelper {
  static String parseDate(String date) {
    try {
      final temp = DateTime.parse(date).toLocal();
      final date0 = DateFormat('EEEE, d MMMM yyyy').format(temp);
      return date0;
    } catch (e) {
      final date0 = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
      return date0;
    }
  }
}
