import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/budget_overview/budget_overview_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/budget/category_budget.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class CategoryBudgetSetupView extends StatefulWidget {
  CategoryBudgetSetupView();

  @override
  _CategoryBudgetSetupViewState createState() => _CategoryBudgetSetupViewState();
}

class _CategoryBudgetSetupViewState extends State<CategoryBudgetSetupView> {
  TextEditingController _budgetTextEditingController = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _budget = 0;

  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFieldForm(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ColoredElevatedButton(
                      child: Text(
                        S.current.statsBudgetSetupSaveButton,
                      ),
                      onPressed: () {
                        _formKey.currentState?.save();

                        if ((_formKey.currentState?.validate() ?? false)) {
                          context
                              .read<BudgetOverviewBloc>()
                              .add(BudgetOverviewCategoryBudgetSaved(categoryBudget: CategoryBudget(category: category, budgetValue: _budget)));
                          Navigator.of(context).pop();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldForm() {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: S.current.statsBudgetSetupSaveDescription,
            prefixText: getCurrencySymbol(state.currency),
          ),
          textAlign: TextAlign.center,
          controller: _budgetTextEditingController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(numberWithDecimalRegExp)),
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (val) {
            if (val == null || !RegExp(moneyAmountRegExp).hasMatch(val)) return S.current.statsBudgetSetupFieldValidatorIncorrect;

            return null;
          },
          onSaved: (value) => _budget = double.tryParse(value ?? "") ?? 0,
        ),
      );
    });
  }
}
