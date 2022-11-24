import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_calendar/transactions_calendar_bloc.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/calendar/widgets/calendar_table.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/widgets/data_loading_widget.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsCalendarBloc, TransactionsCalendarState>(
        builder: (context, state) {
          if (state is TransactionsCalendarLoaded) {
            return CalendarTable(
              days: state.daysData,
            );
          }

          return DataLoadingWidget();
        },
        listener: (context, state) {});
  }
}
