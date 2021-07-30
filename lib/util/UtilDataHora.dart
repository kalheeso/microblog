import 'package:intl/intl.dart';

class UtilDataHora {
  static DateTime convertStringToDate(String date) {
    try {
      return DateFormat("yyyy-MM-dd'T'mm:ss.SSS'Z'", "en_US").parse(date);
    } catch (e) {
      return null;
    }
  }

  static String convertDateTime(DateTime dateTime) {
    try {
      return DateFormat("hh:mm dd/MM").format(dateTime);
    } catch (e) {
      return "";
    }
  }
}
