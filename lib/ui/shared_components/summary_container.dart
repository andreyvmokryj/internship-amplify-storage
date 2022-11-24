import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class SummaryContainer extends StatelessWidget {
  const SummaryContainer({
    Key? key,
    required this.income,
    required this.expenses,
    required this.currency,
  }) : super(key: key);

  final double income;
  final double expenses;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: _totalSectionColumn(
            title: S.current.income,
            currencySymbol: getCurrencySymbol(currency),
            amount: income,
            color: Theme.of(context).primaryColorLight,
            context: context,
          )),
          Expanded(
              child: _totalSectionColumn(
            title: S.current.expenses,
            currencySymbol: getCurrencySymbol(currency),
            amount: expenses,
            color: Theme.of(context).primaryColorDark,
            context: context,
          )),
          Expanded(
              child: _totalSectionColumn(
            title: S.current.total,
            currencySymbol: getCurrencySymbol(currency),
            amount: income - expenses,
            color: Theme.of(context).textTheme.bodyText1?.color,
            context: context,
          )),
        ],
      ),
    );
  }

  Widget _totalSectionColumn({
    required BuildContext context,
    required String title,
    required String currencySymbol,
    required double amount,
    Color? color,
  }) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 8,
        ),
        Text(
          currencySymbol + ' ' + amount.toStringAsFixed(2),
          style: expensesTabStyle(context).copyWith(color: color),
        ),
      ],
    );
  }
}
