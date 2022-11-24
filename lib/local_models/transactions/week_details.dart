class WeekDetails {
  final DateTime firstDay;
  final DateTime lastDay;
  final int weekNumberInSet;
  final String rangeString;
  double income;
  double expenses;

  WeekDetails({
    required this.firstDay,
    required this.lastDay,
    required this.weekNumberInSet,
    required this.income,
    required this.expenses,
    required this.rangeString,
  });
}
