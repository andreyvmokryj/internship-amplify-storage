import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/stats_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_scaffold.dart';
import 'package:radency_internship_project_2/ui/widgets/bottom_nav_bar.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/budget_overview/budget_overview_tab.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/stats/expenses_chart/chart_view.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/stats/expenses_map/expenses_map_view.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/stats/widgets/stats_slider.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      appBar: AppBar(
        title: Text(S.current.stats),
      ),
      header: Column(
        children: [_statsViewModeSlider(), _statsDateSlider()],
      ),
      body: _body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BlocConsumer<StatsBloc, StatsState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.statsPageMode) {
                case StatsPageMode.chart:
                  return ChartView();
                case StatsPageMode.budget:
                  return BudgetOverviewTab();
                case StatsPageMode.map:
                  return ExpensesMapView();
              }

              return SizedBox();
            },
          ),
        )
      ],
    );
  }

  Widget _statsViewModeSlider() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return CupertinoSlidingSegmentedControl(
            children: _statsViewSliderButtons(),
            groupValue: state.statsPageMode,
            onValueChanged: (value) {
              if (value != null) {
                context.read<StatsBloc>().add(
                    StatsPageModeChanged(statsPageMode: value as StatsPageMode));
              }
            },
            thumbColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.black12,
          );
        },
      ),
    );
  }

  Map<StatsPageMode, Widget> _statsViewSliderButtons() {
    Map<StatsPageMode, Widget> statsButtons = {};

    StatsPageMode.values.forEach((statPageMode) {
      switch (statPageMode) {
        case StatsPageMode.chart:
          statsButtons[statPageMode] = _sliderButton(S.current.statsViewChartTab);
          break;
        case StatsPageMode.budget:
          statsButtons[statPageMode] = _sliderButton(S.current.statsViewButtonBudget);
          break;
        case StatsPageMode.map:
          statsButtons[statPageMode] = _sliderButton(S.current.statsViewMapTab);
          break;
      }
    });

    return statsButtons;
  }

  Widget _sliderButton(String title) {
    return Container(width: double.maxFinite, child: Center(child: Text(title, style: tabTitleStyle(context))));
  }

  Widget _statsDateSlider() {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, statsState) {
      switch (statsState.statsPageMode) {
        case StatsPageMode.chart:
          return StatsSlider();
        case StatsPageMode.budget:
          return StatsSlider();
        case StatsPageMode.map:
          return StatsSlider();
        default:
          return Container();
      }
    });
  }
}
