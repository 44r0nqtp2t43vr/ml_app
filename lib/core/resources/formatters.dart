import 'package:intl/intl.dart';

String dateTimeToString(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(dateTime);
}
