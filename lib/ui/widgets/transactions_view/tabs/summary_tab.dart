import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/export_csv/export_csv_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_summary/transactions_summary_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/transactions/summary_details.dart';
import 'package:radency_internship_project_2/ui/shared_components/centered_text_container.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/ui/shared_components/empty_data_refresh_container.dart';
import 'package:radency_internship_project_2/ui/shared_components/summary_container.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/widgets/data_loading_widget.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class SummaryTab extends StatefulWidget {
  SummaryTab();

  @override
  _SummaryTabState createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  @override
  Widget build(BuildContext context) {
    return _buildSummaryContent();
  }

  Widget _buildSummaryContent() {
    return BlocBuilder<TransactionsSummaryBloc, TransactionsSummaryState>(builder: (context, state) {
      if (state is TransactionsSummaryLoading) {
        return DataLoadingWidget();
      }

      if (state is TransactionsSummaryLoaded) {
        if (state.summaryDetails.accountsExpensesDetails.values.isEmpty &&
            state.summaryDetails.income == 0.0 &&
            state.summaryDetails.expenses == 0.0) {
          return EmptyDataRefreshContainer(
            message: S.current.noDataForCurrentDateRangeMessage,
            refreshCallback: () {
              context.read<TransactionsSummaryBloc>().add(TransactionsSummaryRefreshPressed());
            },
          );
        } else {
          return _content(state);
        }
      }

      return SizedBox();
    });
  }

  Widget _content(TransactionsSummaryLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionsSummaryBloc>().add(TransactionsSummaryRefreshPressed());
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: min(MediaQuery.of(context).size.width * 0.9, 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(),
                _buildRowContent(),
                Divider(),
                _buildAccounts(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: BlocBuilder<CsvExportBloc, CsvExportState>(
                    builder: (BuildContext context, csvState) {
                      var csvExportBloc = BlocProvider.of<CsvExportBloc>(context);

                      return ColoredElevatedButton(
                          onPressed: () => csvExportBloc.add(ExportDataToCsv()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_moderator),
                              SizedBox(
                                width: 20,
                              ),
                              Text(S.current.transactionsTabButtonExportToCSV)
                            ],
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowContent() {
    return BlocBuilder<TransactionsSummaryBloc, TransactionsSummaryState>(builder: (context, state) {
      if (state is TransactionsSummaryLoaded) {
        String currency = context.read<SettingsBloc>().state.currency;

        return SummaryContainer(
          income: state.summaryDetails.income,
          expenses: state.summaryDetails.expenses,
          currency: currency,
        );
      }

      return SizedBox();
    });
  }

  Widget _buildAccounts() {
    return BlocBuilder<TransactionsSummaryBloc, TransactionsSummaryState>(builder: (context, state) {
      if (state is TransactionsSummaryLoaded) {
        if (state.summaryDetails.accountsExpensesDetails.values.isEmpty) {
          return CenteredTextContainer(text: S.current.noCategoriesExpensesDetailsMessage);
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: _categoriesExpensesList(state.summaryDetails),
                ),
              ),
            ],
          );
        }
      }

      return SizedBox();
    });
  }

  Widget _accountsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.money,
            ),
            Text(" ${S.current.transactionsTabTitleAccount}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _categoriesExpensesList(SummaryDetails summaryDetails) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(
          summaryDetails.accountsExpensesDetails.length,
          (index) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    summaryDetails.accountsExpensesDetails.keys.elementAt(index),
                    style: expenseDescriptionTextStyle(context),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getCurrencySymbol(
                          context.read<SettingsBloc>().state.currency,
                        ),
                        style: textStyleTransactionListCurrency(color: Theme.of(context).primaryColorDark),
                      ),
                      SizedBox(width: 3),
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                        child: Text(
                          summaryDetails.accountsExpensesDetails.values.elementAt(index).toStringAsFixed(2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textStyleTransactionListAmount(color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              if (index < summaryDetails.accountsExpensesDetails.length - 1)
                SizedBox(
                  height: 10,
                )
            ],
          ),
        ),
      ),
    );
  }
}
