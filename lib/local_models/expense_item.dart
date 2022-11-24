import 'package:radency_internship_project_2/local_models/location.dart';

enum ExpenseType { income, outcome, transfer }

class ExpenseItemEntity {
  const ExpenseItemEntity(this.id, this.type, this.amount, this.dateTime,
      this.category, this.description, {this.expenseLocation});

  final int id;
  final String category;
  final String description;
  final ExpenseType type;
  final double amount;
  final DateTime dateTime;
  final ExpenseLocation? expenseLocation;
}

class ExpenseWeeklyItemEntity {
  const ExpenseWeeklyItemEntity(this.id, this.income, this.outcome, this.weekNumber);

  final int id;
  final double income;
  final double outcome;
  final int weekNumber;
}


class ExpenseMonthlyItemEntity {
  const ExpenseMonthlyItemEntity(this.id, this.income, this.outcome, this.monthNumber);

  final int id;
  final double income;
  final double outcome;
  final int monthNumber;
}

class ExpenseSummaryItemEntity {
  const ExpenseSummaryItemEntity(this.id, this.income, this.outcomeCash, this.outcomeCreditCards);

  final int id;
  final double income;
  final double outcomeCash;
  final double outcomeCreditCards;
}
