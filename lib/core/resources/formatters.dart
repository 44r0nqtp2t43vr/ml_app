import 'package:intl/intl.dart';

String dateTimeToString(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(dateTime);
}

String dateTimeToFilename(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyyMM");
  return dateFormat.format(dateTime);
}
