import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/local_models/chart_models/chart_section.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<ChartSection> expensesData;

  PieOutsideLabelChart({required this.expensesData});

  @override
  Widget build(BuildContext context) {
    if (expensesData.isEmpty) {
      return SizedBox();
    } else {
      return Container(
        child: new PieChart(
          createChartSections(context),
          defaultRenderer: new ArcRendererConfig(
            arcWidth: min((MediaQuery.of(context).size.width * 0.05).toInt(), 30),
            arcRendererDecorators: [
              new ArcLabelDecorator(labelPosition: ArcLabelPosition.outside),
            ],
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: min(MediaQuery.of(context).size.width * 0.5 + 20, 300),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
      );
    }
  }

  List<Series<ChartSection, dynamic>> createChartSections(BuildContext context) {
    return [
      Series(
        data: expensesData,
        domainFn: (expense, _) => expense.categoryName,
        measureFn: (expense, _) => expense.percents,
        colorFn: (expense, _) {
          return Color.fromOther(
              color: Color(r: expense.color!.red, g: expense.color!.green, b: expense.color!.blue, a: 255));
        },
        id: "expense",
        labelAccessorFn: (expense, _) => '${expense.categoryName}\n${expense.percents.toStringAsFixed(2)}%',
        outsideLabelStyleAccessorFn: (expense, _) => chartLabelStyle(context),
      )
    ];
  }
}
