import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_daily/transactions_daily_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/ui/shared_components/centered_text_container.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/widgets/data_loading_widget.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';
import 'package:radency_internship_project_2/utils/time.dart';

import 'common_transactions_list.dart';

class DailyTransactionList extends StatelessWidget {
  const DailyTransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsDailyBloc, TransactionsDailyState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TransactionsDailyLoaded) {
            if (state.dailySortedTransactions == null || state.dailySortedTransactions.isEmpty) {
              return CenteredTextContainer(text: S.current.noDataForCurrentDateRangeMessage);
            } else {
              return content(state);
            }
          } else if (state is TransactionsDailyLoading) {
            return DataLoadingWidget();
          }

          return SizedBox();
        });
  }

  Widget content(TransactionsDailyLoaded state) {
    var sliversMap = List<_StickyExpensesDaily>.empty(growable: true);

    state.dailySortedTransactions.forEach((key, value) {
      sliversMap.add(_StickyExpensesDaily(items: value));
    });

    return CustomScrollView(
      slivers: sliversMap,
    );
  }
}

class _StickyExpensesDaily extends StatelessWidget {
  const _StickyExpensesDaily({Key? key, required this.items}) : super(key: key);

  final List<AppTransaction> items;

  @override
  Widget build(BuildContext context) {
    var totalIncome = 0.0;
    var totalOutcome = 0.0;

    items.forEach((element) {
      if (element.transactionType == TransactionType.Income) {
        totalIncome += element.amount;
      } else if (element.transactionType == TransactionType.Expense) {
        totalOutcome += element.amount;
      }
    });

    return SliverStickyHeader(
      header: DailyExpensesHeader(
        dateTime: items[0].date.getDateTimeInUtc(),
        incomeTotal: totalIncome,
        outcomeTotal: totalOutcome,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => Dismissible(
            onDismissed: (direction) =>
                context.read<TransactionsDailyBloc>().add(TransactionDailyDelete(transactionId: items[i].id)),
            key: Key(items[i].id),
            child: ListTile(
              title: DailyTransactionItem(transaction: items[i]),
            ),
          ),
          childCount: items.length,
        ),
      ),
    );
  }
}

class DailyTransactionItem extends StatelessWidget {
  const DailyTransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final AppTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      String currency = state.currency;

      var amountColor = getAmountColor(transaction, context);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
            child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                getCategory(transaction),
                style: transactionsListDescriptionTextStyle(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${transaction.note}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: transactionsListDescriptionTextStyle(),
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(children: [
                  TextSpan(
                      text: getCurrencySymbol(currency),
                      style: textStyleTransactionListCurrency(size: 16, fontWeight: FontWeight.w600, color: amountColor)),
                  TextSpan(
                      text: '${transaction.amount.toStringAsFixed(2)}',
                      style: transactionsListDescriptionTextStyle(fontWeight: FontWeight.w600, color: amountColor))
                ]
              )
            )),
          ],
        )),
      );
    });
  }

  Color getAmountColor(AppTransaction transaction, BuildContext context) {
    Color color;

    switch (transaction.transactionType) {
      case TransactionType.Income:
        color = Theme.of(context).primaryColorLight;
        break;
      case TransactionType.Expense:
        color = Theme.of(context).primaryColorDark;
        break;
      case TransactionType.Transfer:
        color = Colors.grey;
        break;
    }

    return color;
  }

  String getCategory(AppTransaction transaction) {
    String result = '';

    switch (transaction.transactionType) {
      case TransactionType.Income:
        result = transaction.category!;
        break;
      case TransactionType.Expense:
        result = transaction.category!;
        break;
      case TransactionType.Transfer:
        result =
            '${transaction.accountOrigin} > ${transaction.accountDestination}';
        break;
    }

    return result;
  }
}

class DailyExpensesHeader extends StatelessWidget {
  const DailyExpensesHeader({
    Key? key,
    required this.dateTime,
    this.incomeTotal = 0.0,
    this.outcomeTotal = 0.0,
  }) : super(key: key);

  final DateTime dateTime;
  final double incomeTotal;
  final double outcomeTotal;

  Widget buildDateText(context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text('${toFancyDay(dateTime.day)}.${toFancyDay(dateTime.month)}.${dateTime.year}',
            style: textStyleHeader(color: Theme.of(context).secondaryHeaderColor)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      String currency = state.currency;
      return Container(
          color: Theme.of(context).backgroundColor,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                buildDateText(context),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.end,
                      children: [
                        buildIncomeText(context, getCurrencySymbol(currency), incomeTotal),
                        buildOutcomeText(context, getCurrencySymbol(currency), outcomeTotal)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
