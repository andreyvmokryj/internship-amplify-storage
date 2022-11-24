import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/local_models/budget/monthly_category_expense.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class ExpenseCategoryBudgetItem extends StatelessWidget {
  final MonthlyCategoryExpense monthlyCategoryExpense;

  final double progressIndicatorHeight = 25;
  final double verticalPadding = 4;
  final double horizontalPadding = 16;

  ExpenseCategoryBudgetItem({required this.monthlyCategoryExpense});

  @override
  Widget build(BuildContext context) {
    if (monthlyCategoryExpense.budgetTotal == 0) {
      return _budgetUnlimitedCategoryItem(context);
    } else {
      return _budgetLimitedCategoryItem();
    }
  }

  Widget _budgetLimitedCategoryItem() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: _budgetLimitedCategoryTitleAndExpense(),
              ),
              Flexible(
                flex: 3,
                child: budgetLimitedProgressBar(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _budgetLimitedCategoryTitleAndExpense() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              monthlyCategoryExpense.category,
              style: budgetItemLimitedAndRemainingTitleStyle,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getCurrencySymbol(context.read<SettingsBloc>().state.currency),
                  style: textStyleTransactionListCurrency(color: Theme.of(context).textTheme.bodyText1?.color, size: 20),
                ),
                Text(
                  '${monthlyCategoryExpense.budgetTotal.toStringAsFixed(2)}',
                  style: budgetItemLimitedTotalBudgetAmountStyle,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget budgetLimitedProgressBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Stack(
            children: [
              LinearProgressIndicator(
                minHeight: progressIndicatorHeight,
                backgroundColor: Colors.grey.shade300,
                value: monthlyCategoryExpense.budgetUsage,
                valueColor: monthlyCategoryExpense.budgetUsage < 1
                    ? AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight)
                    : AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
              ),
              Container(
                  alignment: Alignment(0.95, 0),
                  height: progressIndicatorHeight,
                  child: Text(
                    '${(monthlyCategoryExpense.budgetUsage * 100).toStringAsFixed(0)}%',
                    style: budgetItemLimitedIndicatorPercentageStyle,
                  )),
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                '${monthlyCategoryExpense.expenseAmount.toStringAsFixed(2)}',
                style: budgetItemLimitedExpenseAmountStyle(
                    context: context,
                    isOverBudget: monthlyCategoryExpense.expenseAmount >= monthlyCategoryExpense.budgetTotal),
              ),
              Text(
                monthlyCategoryExpense.budgetLeft.toStringAsFixed(2),
                style: budgetItemLimitedTotalBudgetAmountStyle,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _budgetUnlimitedCategoryItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            monthlyCategoryExpense.category,
            style: budgetItemUnlimitedTitleStyle,
          ),
          SizedBox(
            width: 2,
          ),
          Flexible(
            child: Text(
              monthlyCategoryExpense.expenseAmount.toStringAsFixed(2),
              style: budgetItemUnlimitedExpenseAmountStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
