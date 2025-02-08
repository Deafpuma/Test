import 'package:intl/intl.dart';

class UIHelper {
  static String formatNumber(int number) {
    final NumberFormat formatter = NumberFormat.compact();
    return formatter.format(number);
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}