import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class DateHelper {
  String dateToString(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  String dateToNbuString(DateTime dateTime, {String? locale}) {
    return DateFormat('ddMMyyyy').format(dateTime);
  }

  String dateToTransactionDateString(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy (EEE)').format(dateTime);
  }

  String yearFromDateTimeString(DateTime dateTime) {
    return DateFormat('y').format(dateTime);
  }

  String monthNameAndYearFromDateTimeString(DateTime dateTime, {String? locale}) {
    return capitalizeFirstLetterOfEachWord(DateFormat('LLLL y', locale).format(dateTime));
  }

  DateTime getFirstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  DateTime getLastDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 1).subtract(Duration(seconds: 1));

  }

  DateTime getFirstDayOfYear(DateTime dateTime) {
    return DateTime(dateTime.year, 1, 1);
  }

  DateTime getLastDayOfYear(DateTime dateTime) {
    return DateTime(dateTime.year, 13, 1).subtract(Duration(seconds: 1));
  }

  String getWeeksRangeString({required DateTime firstDay, required DateTime lastDay, bool oneWeekMode = false}) {
    String range = '';

    range = '${appendZeroToSingleDigit(firstDay.day)}.'
        '${appendZeroToSingleDigit(firstDay.month)}'
        '${firstDay.year != lastDay.year && !oneWeekMode ? '.${firstDay.year}' : ''}'
        ' ~ '
        '${appendZeroToSingleDigit(lastDay.day)}.'
        '${appendZeroToSingleDigit(lastDay.month)}'
        '${!oneWeekMode ? '.' + lastDay.year.toString() : ''}';

    return range;
  }

  String appendZeroToSingleDigit(int number) {
    return '${number < 10 ? '0' : ''}${number.toString()}';
  }
}
