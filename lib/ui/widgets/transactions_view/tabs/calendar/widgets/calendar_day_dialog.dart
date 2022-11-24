import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/calendar_day.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/ui/widgets/daily_transactions_list.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class CalendarDayDialog extends StatefulWidget {
  const CalendarDayDialog({Key? key, required this.day, required this.currencySymbol}) : super(key: key);

  final CalendarDay day;
  final String currencySymbol;

  @override
  _CalendarDayDialogState createState() => _CalendarDayDialogState();
}

class _CalendarDayDialogState extends State<CalendarDayDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.all(20.0),
      contentPadding: EdgeInsets.all(10.0),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _daySummary(widget.day),
              _transactionsList(widget.day.transactions),
            ],
          ),
        ),
      ),
    );
  }

  Widget _daySummary(CalendarDay day) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is LoadedSettingsState) {
          return DailyExpensesHeader(
            dateTime: day.dateTime,
            incomeTotal: day.incomeAmount,
            outcomeTotal: day.expensesAmount,
          );
        }

        return SizedBox();
      },
    );
  }

  Widget _transactionsList(List<AppTransaction> transactions) {
    if (transactions.isEmpty) {
      return SizedBox();
    } else {
      return Column(
        children: List.generate(
          transactions.length,
          (index) => Column(
            children: [Divider(), _transactionData(transactions[index])],
          ),
        ),
      );
    }
  }

  Widget _transactionData(AppTransaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.Income:
        return _transactionRow(
          children: [
            _expandedContainer(child: Text(transaction.category!)),
            _expandedContainer(child: Text(transaction.accountOrigin)),
            _expandedContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.currencySymbol + ' ',
                    style: textStyleTransactionListCurrency(color: Theme.of(context).primaryColorLight),
                  ),
                  Text(
                    transaction.amount.toStringAsFixed(2),
                    style: textStyleTransactionListAmount(color: Theme.of(context).primaryColorLight),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        );
      case TransactionType.Expense:
        return _transactionRow(
          children: [
            _expandedContainer(child: Text(transaction.category!)),
            _expandedContainer(child: Text(transaction.accountOrigin)),
            _expandedContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.currencySymbol + ' ',
                    style: textStyleTransactionListCurrency(color: Theme.of(context).primaryColorDark),
                  ),
                  Text(
                    transaction.amount.toStringAsFixed(2),
                    style: textStyleTransactionListAmount(color: Theme.of(context).primaryColorDark),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        );
      case TransactionType.Transfer:
        return _transactionRow(
          children: [
            _expandedContainer(child: Text(S.current.transfer)),
            _expandedContainer(
                child: Text(
                    '${transaction.accountOrigin} \u{2192} ${transaction.accountDestination}')),
            _expandedContainer(
              child: Text(
                widget.currencySymbol + ' ' + transaction.amount.toStringAsFixed(2),
                style: textStyleTransactionListAmount(color: Colors.grey),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        );
      default:
        return SizedBox();
    }
  }

  Widget _transactionRow({required List<Widget> children}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
      // constraints: BoxConstraints(maxWidth: min(MediaQuery.of(context).size.width * 0.9, 380)),
    );
  }

  Widget _expandedContainer({required Widget child}) {
    return Expanded(
      child: Container(child: child),
      flex: 1,
    );
  }
}
