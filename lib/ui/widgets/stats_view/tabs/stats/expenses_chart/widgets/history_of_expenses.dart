import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/local_models/chart_models/chart_category_details.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class HistoryOfExpenses extends StatelessWidget {
  HistoryOfExpenses({required this.expensesData});

  final List<ChartCategoryDetails> expensesData;

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Column(
        children: createHistoryOfExpenses(expensesData, state.currency, context),
      );
    }));
  }

  List<Widget> createHistoryOfExpenses(expensesData, currency, context) {
    List<Widget> expensesHistory = [];
    for (ChartCategoryDetails category in expensesData) {
      Widget singleRow;

      singleRow = createSingleRow(category, currency, context);
      expensesHistory.add(singleRow);
    }
    return expensesHistory;
  }

  Widget createSingleRow(category, currency, context) {
    String name = category.categoryName;
    double categoryInPercents = category.percents;
    double categoryInCurrency = category.value;
    Color color = category.color;

    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[100]!, width: 1)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
                    child: Text(
                      '$categoryInPercents%',
                      style: chartExpenseAmountTextStyle(context),
                    )),
                Text(
                  name,
                  style: expenseDescriptionTextStyle(context),
                ),
              ],
            ),
            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: getCurrencySymbol(currency), style: chartExpenseCurrencyTextStyle(context)),
                  TextSpan(
                    text: ' ${categoryInCurrency.toStringAsFixed(2) ?? ''}',
                    style: chartExpenseAmountTextStyle(context),
                  )
                ]),
              ),
            )
          ],
        ));
  }
}
