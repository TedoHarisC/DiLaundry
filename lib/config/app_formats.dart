import 'package:intl/intl.dart';

class AppFormats {
  static String shortPrice(num number) {
    return NumberFormat.compactCurrency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  static String longPrice(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(number);
  }

  static String justDate(DateTime dateTime) {
    return DateFormat.yMMMMd('id_ID').format(dateTime);
  }

  static String shortDate(dynamic source) {
    switch (source.runtimeType) {
      case DateTime _:
        return DateFormat('EEEE, dd MMM yyyy').format(source);
      case String _:
        return DateFormat(
          'EEEE, dd MMM yyyy',
        ).format(DateTime.parse(source).toLocal());
      default:
        return 'Not Valid';
    }
  }

  static String fullDate(dynamic source) {
    switch (source.runtimeType) {
      case DateTime _:
        return DateFormat('EEEE, dd MMMM yyyy').format(source);
      case String _:
        return DateFormat(
          'EEEE, dd MMMM yyyy',
        ).format(DateTime.parse(source).toLocal());
      default:
        return 'Not Valid';
    }
  }
}
