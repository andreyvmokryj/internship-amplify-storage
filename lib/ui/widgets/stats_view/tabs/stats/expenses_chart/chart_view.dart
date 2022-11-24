import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/expenses_chart/expenses_chart_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/empty_data_refresh_container.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/stats/expenses_chart/widgets/chart.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/stats/expenses_chart/widgets/history_of_expenses.dart';

class ChartView extends StatefulWidget {
  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  Widget build(BuildContext context) {
    return Container(child: content());
  }

  Widget content() {
    return BlocBuilder<ExpensesChartBloc, ExpensesChartState>(builder: (context, state) {
      if (state is ExpensesChartLoaded) {
        if (state.chartCategories.isEmpty) {
          return EmptyDataRefreshContainer(
            message: S.current.noCategoriesExpensesDetailsMessage,
            refreshCallback: () => context.read<ExpensesChartBloc>().add(ExpensesChartRefreshPressed()),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => context.read<ExpensesChartBloc>().add(ExpensesChartRefreshPressed()),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PieOutsideLabelChart(expensesData: state.chartCategories),
                HistoryOfExpenses(expensesData: state.allCategories),
              ],
            ),
          ),
        );
      }

      return SizedBox();
    });
  }
}
