class MonthDetails {
  int monthNumber;
  double income;
  double expenses;

  MonthDetails({required this.monthNumber, required this.income, required this.expenses});

  factory MonthDetails.fromSnapshot(String key, Map<dynamic, dynamic> snapshot) {

    print("MonthlySummary.fromSnapshot: key $key snapshot ${snapshot.toString()}");

    return MonthDetails(
      monthNumber: int.tryParse(key) ?? 0,
      income: double.tryParse(snapshot['income'].toString()) ?? 0,
      expenses: double.tryParse(snapshot['expense'].toString()) ?? 0,
    );
  }
}
