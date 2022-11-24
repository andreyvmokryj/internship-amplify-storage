import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_monthly/transactions_monthly_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/transactions/month_details.dart';
import 'package:radency_internship_project_2/ui/shared_components/empty_data_refresh_container.dart';
import 'package:radency_internship_project_2/ui/widgets/common_transactions_list.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class MonthlyTransactionsList extends StatelessWidget {
  const MonthlyTransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsMonthlyBloc, TransactionsMonthlyState>(builder: (context, state) {
      if (state is TransactionsMonthlyLoaded) {
        if (state.yearSummary.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TransactionsMonthlyBloc>().add(TransactionMonthlyRefreshPressed());
            },
            child: ListView.builder(
              itemCount: state.yearSummary.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: MonthlyDetailsItem(itemEntity: state.yearSummary[index]),
                );
              },
            ),
          );
        } else {
          return EmptyDataRefreshContainer(
            message: S.current.noDataForCurrentDateRangeMessage,
            refreshCallback: () => context.read<TransactionsMonthlyBloc>().add(TransactionMonthlyRefreshPressed()),
          );
        }
      }

      return SizedBox();
    });
  }
}

class MonthlyDetailsItem extends StatelessWidget {
  const MonthlyDetailsItem({
    Key? key,
    required this.itemEntity,
  }) : super(key: key);

  final MonthDetails itemEntity;

  @override
  Widget build(BuildContext context) {
    const greyColor = Color(0xff8d8d8d);

    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      String currency = state.currency;
      return Container(
          child: Row(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '${getMonthByNumber(context, itemEntity.monthNumber)}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: greyColor, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.end,
                  children: [
                    buildIncomeText(context, getCurrencySymbol(currency), itemEntity.income),
                    buildOutcomeText(context, getCurrencySymbol(currency), itemEntity.expenses)
                  ],
                ),
              )
            ],
          ));
    });
  }
}
