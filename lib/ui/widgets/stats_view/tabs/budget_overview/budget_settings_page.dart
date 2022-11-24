import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/mocked_expenses.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class BudgetSettingsPage extends StatefulWidget {
  @override
  _BudgetSettingsPageState createState() => _BudgetSettingsPageState();
}

class _BudgetSettingsPageState extends State<BudgetSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.statsBudgetViewBudgetSettingsTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              TempTransactionsValues().expenseCategories.length,
              (index) => Column(
                    children: [
                      Divider(),
                      categoryItem(context, MockedExpensesItems().expenseCategories[index]),
                    ],
                  )),
        ),
      ),
    );
  }

  Widget categoryItem(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        child: Container(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: budgetItemUnlimitedTitleStyle,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.categoryBudgetSetupView, arguments: title);
        },
      ),
    );
  }
}
