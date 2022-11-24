import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class SummaryRowWidget extends StatelessWidget{
  final double income;
  final double outcome;
  final double transfer;
  final String currency;

  const SummaryRowWidget({Key? key, required this.income, required this.outcome, required this.transfer, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildRowItem(
            context,
            title: S.current.income,
            currencySymbol: getCurrencySymbol(currency),
            amount: income,
            color: Colors.blue,
          )
        ),
        Expanded(
          child: _buildRowItem(
            context,
            title: S.current.expenses,
            currencySymbol: getCurrencySymbol(currency),
            amount: outcome,
            color: Colors.red,
          )
        ),
        Expanded(
          child: _buildRowItem(
            context,
            title: S.current.transfer,
            currencySymbol: getCurrencySymbol(currency),
            amount: transfer,
          )
        ),
      ],
    );
  }

  Widget _buildRowItem(BuildContext context, {required String title, required String currencySymbol, required double amount, Color? color}){
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 10,
        ),
        Text(
          "$currencySymbol " + getMoneyFormatted(amount, separator: " ", comma: "."),
          style: expensesTabStyle(context).copyWith(color: color),
        ),
      ],
    );
  }
}