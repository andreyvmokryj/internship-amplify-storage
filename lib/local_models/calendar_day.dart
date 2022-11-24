import 'package:radency_internship_project_2/models/AppTransaction.dart';

class CalendarDay {
  DateTime dateTime;
  String displayedDate;
  bool isActive;
  double incomeAmount;
  double expensesAmount;
  double transferAmount;
  List<AppTransaction> transactions;

  CalendarDay({
    required this.displayedDate,
    required this.dateTime,
    required this.isActive,
    required this.transactions,
    this.transferAmount = 0,
    this.incomeAmount = 0,
    this.expensesAmount = 0,
  });
}
