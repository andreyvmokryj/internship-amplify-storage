String getWeekStartToEndDateByWeekNumber(int weekNumber) {
  final date = new DateTime.now();
  final startOfYear = new DateTime(date.year, 1, 1, 0, 0);

  final start = startOfYear.add(Duration(days: 7 * weekNumber));
  final end = startOfYear.add(Duration(days: 7 * weekNumber + 6));

  return "${toFancyDay(start.day)}.${toFancyDay(start.month)}-${toFancyDay(end.day)}.${toFancyDay(end.month)}";
}

String toFancyDay(int date) {
  var dateString = date <= 9 ? "0$date" : date;
  return dateString.toString();
}