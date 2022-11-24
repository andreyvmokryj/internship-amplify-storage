import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:radency_internship_project_2/local_models/budget/monthly_category_expense.dart';
import 'package:radency_internship_project_2/local_models/expense_item.dart';
import 'package:radency_internship_project_2/local_models/location.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';

class MockedExpensesItems {
  final List<String> incomeCategories = TempTransactionsValues().incomeCategories;
  final List<String> expenseCategories = TempTransactionsValues().expenseCategories;
  final List<String> accounts = ['Cash', 'Bank accounts', 'Credit cards'];

  Map<int, List<ExpenseItemEntity>> generateDailyData({double? locationLatitude, double? locationLongitude}) {
    var map = Map<int, List<ExpenseItemEntity>>();

    var list = List<ExpenseItemEntity>.empty(growable: true);

    for (int j = 1; j < 100; j++) {
      var date = Random().nextInt(29) + 1;
      var dateString = date <= 9 ? "0$date" : date.toString();

      double newLatitude = 0;
      double newLongitude = 0;

      if (locationLatitude != null && locationLongitude != null) {
        newLatitude = locationLatitude + (Random().nextInt(9) * 0.01);
        newLongitude = locationLongitude + (Random().nextInt(9) * 0.01);
      }

      ExpenseLocation expenseLocation = ExpenseLocation(address: '', latitude: newLatitude, longitude: newLongitude);

      list.add(ExpenseItemEntity(j, j % 2 == 0 ? ExpenseType.income : ExpenseType.outcome, 5 * sqrt(j) * j - sqrt(j) * j + j + sqrt(j),
          DateTime.parse("2021-04-$dateString"), "Catname", "Description $j", expenseLocation: expenseLocation));
    }

    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    var currentDay = 0;
    var currentList = List<ExpenseItemEntity>.empty(growable: true);

    list.forEach((element) {
      var itemDay = element.dateTime.day;

      if (currentDay == 0) {
        currentDay = itemDay;
      }

      if (currentDay != itemDay || list.last == element) {
        map[currentDay] = currentList.toList();
        currentDay = itemDay;
        currentList.clear();
      }

      currentList.add(element);
    });

    return map;
  }

  ExpenseSummaryItemEntity generateSummaryData() {
    double income = 100 * sqrt(Random().nextInt(100) + 1);
    double outcomeCash = 100 * sqrt(Random().nextInt(25) + 1);
    double outcomeCreditCards = 100 * sqrt(Random().nextInt(25) + 1);

    return ExpenseSummaryItemEntity(1, income, outcomeCash, outcomeCreditCards);
  }

  Future<List<MonthlyCategoryExpense>> generateMonthlyCategoryExpenses() async {
    List<MonthlyCategoryExpense> list = [];

    expenseCategories.forEach((category) {
      bool expensesAvailable = Random().nextBool();
      list.add(MonthlyCategoryExpense(category: category, expenseAmount: expensesAvailable ? Random().nextDouble() * Random().nextInt(1000) : 0.0));
    });

    await Future.delayed(Duration(seconds: 1));
    return list;
  }

  List<Map<String, double>> summaryExpensesByCategories() {
    List<Map<String, double>> expensesByCategories = [];

    for(String category in expenseCategories) {
      double categorySum = (Random().nextDouble() * Random().nextInt(1000));
      double roundedCategorySum = double.parse(categorySum.toInt().toStringAsFixed(2));
      expensesByCategories.add({category: roundedCategorySum});
    }
    return expensesByCategories;
  }

  List<AppTransaction> generateSearchData() {
    if(transactionList.isEmpty) {
      for (int j = 0; j < 5; j++) {
        var _today = DateTime.now();
        int day = Random().nextInt(20) + 1;
        int categoryIndex = Random().nextInt(expenseCategories.length);
        int accountIndex = Random().nextInt(accounts.length);

        transactionList.add(AppTransaction(
          transactionType: TransactionType.Expense,
          date: TemporalDateTime(_today.subtract(Duration(days: day))),
          accountOrigin: accounts[accountIndex],
          category: expenseCategories[categoryIndex],
          amount: Random().nextInt(10000) / 100.0, currency: 'UAH', note: '', creationType: ExpenseCreationType.MANUAL, locationLatitude: 0, locationLongitude: 0,
        ));

        day = Random().nextInt(20) + 1;
        categoryIndex = Random().nextInt(incomeCategories.length);
        accountIndex = Random().nextInt(accounts.length);

        transactionList.add(AppTransaction(
          transactionType: TransactionType.Income,
          date: TemporalDateTime(_today.subtract(Duration(days: day))),
          accountOrigin: accounts[accountIndex],
          category: incomeCategories[categoryIndex],
          amount: Random().nextInt(10000) / 100.0, note: '', currency: 'UAH',
        ));

        day = Random().nextInt(20) + 1;
        categoryIndex = Random().nextInt(11);
        accountIndex = Random().nextInt(3);

        transactionList.add(AppTransaction(
          transactionType: TransactionType.Transfer,
          date: TemporalDateTime(_today.subtract(Duration(days: day))),
          accountOrigin: accounts[accountIndex],
          accountDestination: accounts[(accountIndex + 1) % 3],
          amount: Random().nextInt(10000) / 100.0, note: '', fees: 0.0, currency: '',
        ));
      }
    }
    transactionList.sort((a, b) => b.date.compareTo(a.date));
    return transactionList;
  }

  List<AppTransaction> searchDataByFilters({
    List<String>? searchAccounts, List<String>? searchCategories, double? minAmount, double? maxAmount
  }) {
    List<AppTransaction> list = List<AppTransaction>.of(transactionList);

    transactionList.forEach((element) {
      if(
      (searchAccounts ?? []).isNotEmpty &&
        !(searchAccounts!.contains(element.accountOrigin))
      ){
        list.remove(element);
      }

      if(
      (searchCategories ?? []).isNotEmpty &&
        !((element.transactionType == TransactionType.Expense && searchCategories!.contains(element.category)) ||
           element.transactionType == TransactionType.Income && searchCategories!.contains(element.category))
      ){
        list.remove(element);
      }

      if(element.amount < (minAmount ?? 0) || element.amount > (maxAmount ?? double.infinity)){
        list.remove(element);
      }
    });

    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  static List<AppTransaction> transactionList = [];
}
