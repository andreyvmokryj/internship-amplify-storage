import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/calendar/calendar_tab.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/daily_tab.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/monthly_tab.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/summary_tab.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/weekly_tab.dart';

class TransactionsContent extends StatefulWidget {
  final TabController tabBarController;

  const TransactionsContent({Key? key, required this.tabBarController}) : super(key: key);

  @override
  _TransactionsContentState createState() => _TransactionsContentState();
}

class _TransactionsContentState extends State<TransactionsContent> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // GestureDetector(
        //   onHorizontalDragUpdate: (details) {
        //     if (details.delta.dx > 0
        //     // && details.localPosition.dx > 0
        //     ) {
        //       print("onHorizontalDragUpdate: Moved right");
        //     }
        //   },
        // ),
        TabBarView(
          controller: widget.tabBarController,
          children: [
            DailyTab(),
            CalendarTab(),
            WeeklyTab(),
            MonthlyTab(),
            SummaryTab(),
          ],
        ),
      ],
    );
  }
}
