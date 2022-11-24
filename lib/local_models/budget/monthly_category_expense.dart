class MonthlyCategoryExpense {
  String category;
  double expenseAmount;
  double budgetTotal;
  double budgetLeft;
  double budgetUsage;

  MonthlyCategoryExpense({required this.category, required this.expenseAmount, this.budgetTotal = 0, this.budgetLeft = 0, this.budgetUsage = 0});
}
