import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_weekly/transactions_weekly_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/transactions/week_details.dart';
import 'package:radency_internship_project_2/ui/shared_components/empty_data_refresh_container.dart';
import 'package:radency_internship_project_2/ui/widgets/common_transactions_list.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class WeeklySummaryList extends StatelessWidget {
  const WeeklySummaryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsWeeklyBloc, TransactionsWeeklyState>(builder: (context, state) {
      if (state is TransactionsWeeklyLoaded) {
        if (state.summaryList.isEmpty) {
          return EmptyDataRefreshContainer(
            message: S.current.noDataForCurrentDateRangeMessage,
            refreshCallback: () => context.read<TransactionsWeeklyBloc>().add(TransactionWeeklyRefreshPressed()),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async => context.read<TransactionsWeeklyBloc>().add(TransactionWeeklyRefreshPressed()),
            child: ListView.builder(
              itemCount: state.summaryList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: WeeklyDetailsItem(itemEntity: state.summaryList[index]),
                );
              },
            ),
          );
        }
      }

      return SizedBox();
    });
  }
}

class WeeklyDetailsItem extends StatelessWidget {
  const WeeklyDetailsItem({
    Key? key,
    required this.itemEntity,
  }) : super(key: key);

  final WeekDetails itemEntity;

  @override
  Widget build(BuildContext context) {
    const greyColor = Color(0xff8d8d8d);

    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      String currency = state.currency;
      return Container(
          child: Row(
            children: [
              Text(
                '${itemEntity.rangeString}',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: greyColor, fontSize: 18),
              ),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    buildIncomeText(context, getCurrencySymbol(currency), itemEntity.income),
                    buildOutcomeText(context, getCurrencySymbol(currency), itemEntity.expenses)
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
