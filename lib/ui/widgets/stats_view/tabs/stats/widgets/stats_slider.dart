import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/budget_overview/budget_overview_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/expenses_chart/expenses_chart_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/expenses_map/expenses_map_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/stats_bloc.dart';
import 'package:radency_internship_project_2/ui/widgets/slider.dart';

class StatsSlider extends StatefulWidget {
  StatsSlider();

  @override
  _StatsSliderState createState() => _StatsSliderState();
}

class _StatsSliderState extends State<StatsSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
      switch (state.statsPageMode) {
        case StatsPageMode.chart:
          return _chartSlider(context);
        case StatsPageMode.map:
          return _expensesMapSlider(context);
        case StatsPageMode.budget:
          return _budgetSlider(context);
        default:
          return SizedBox();
      }
    });
  }
}

Widget _budgetSlider(BuildContext context) {
  return BlocBuilder<BudgetOverviewBloc, BudgetOverviewState>(builder: (context, state) {
    if (state is BudgetOverviewLoading)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onBackPressed: () {
            context.read<BudgetOverviewBloc>().add(BudgetOverviewGetPreviousMonthPressed());
          },
          onForwardPressed: () {
            context.read<BudgetOverviewBloc>().add(BudgetOverviewGetNextMonthPressed());
          });

    if (state is BudgetOverviewLoaded)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onBackPressed: () {
            context.read<BudgetOverviewBloc>().add(BudgetOverviewGetPreviousMonthPressed());
          },
          onForwardPressed: () {
            context.read<BudgetOverviewBloc>().add(BudgetOverviewGetNextMonthPressed());
          });

    return DateRangeSlider(content: '', onBackPressed: () {}, onForwardPressed: () {});
  });

}

Widget _chartSlider(BuildContext context) {
  void Function() onMapSliderBackPressed = () {
    return context.read<ExpensesChartBloc>().add(ExpensesChartGetPreviousMonthPressed());
  };

  void Function() onMapSliderForwardPressed = () {
    return context.read<ExpensesChartBloc>().add(ExpensesChartGetNextMonthPressed());
  };

  return BlocBuilder<ExpensesChartBloc, ExpensesChartState>(builder: (context, state) {
    if (state is ExpensesChartLoaded) {
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onForwardPressed: onMapSliderForwardPressed,
          onBackPressed: onMapSliderBackPressed);
    }

    if (state is ExpensesChartLoading) {
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onForwardPressed: onMapSliderForwardPressed,
          onBackPressed: onMapSliderBackPressed);
    }

    return SizedBox();
  });
}

Widget _expensesMapSlider(BuildContext context) {
  void Function() onMapSliderBackPressed = () {
    return context.read<ExpensesMapBloc>().add(ExpensesMapSliderBackPressed());
  };

  void Function() onMapSliderForwardPressed = () {
    return context.read<ExpensesMapBloc>().add(ExpensesMapSliderForwardPressed());
  };

  return BlocBuilder<ExpensesMapBloc, ExpensesMapState>(builder: (context, state) {
    return DateRangeSlider(
        content: state.sliderCurrentTimeIntervalString,
        onForwardPressed: onMapSliderForwardPressed,
        onBackPressed: onMapSliderBackPressed);
  });
}
