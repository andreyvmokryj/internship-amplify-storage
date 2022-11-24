import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/transactions/transactions_weekly/transactions_weekly_bloc.dart';
import '../../../../ui/widgets/transactions_view/widgets/data_loading_widget.dart';
import '../../weekly_expenses_list.dart';

class WeeklyTab extends StatefulWidget {
  WeeklyTab();

  @override
  _WeeklyTabState createState() => _WeeklyTabState();
}

class _WeeklyTabState extends State<WeeklyTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _weeklyContent()
    );
  }

  Widget _weeklyContent() {
    return BlocBuilder<TransactionsWeeklyBloc, TransactionsWeeklyState>(builder: (context, state) {
      if (state is TransactionsWeeklyLoading) return DataLoadingWidget();

      if (state is TransactionsWeeklyLoaded) return WeeklySummaryList();

      return SizedBox();
    });
  }
}
