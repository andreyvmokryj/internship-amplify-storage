import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_calendar/transactions_calendar_bloc.dart';
import 'package:radency_internship_project_2/local_models/calendar_day.dart';
import 'package:radency_internship_project_2/ui/shared_components/summary_container.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';
import 'package:radency_internship_project_2/utils/ui_utils.dart';

import 'day_cell.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({Key? key, required this.days}) : super(key: key);

  final List<CalendarDay> days;

  @override
  _CalendarTableState createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _summarySection(),
        _weekDaysSection(),
        _calendarSection(),
      ],
    );
  }

  Widget _weekDaysSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Row(
        children: List.generate(
            7,
            (index) => Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.grey),
                        left: BorderSide(width: 1, color: Colors.grey),
                        right: BorderSide(width: 1, color: Colors.grey)),
                  ),
                  child: Text(
                    getWeekDayByNumber(index + 1, context),
                    textAlign: TextAlign.center,
                    style: expenseDescriptionTextStyle(context),
                  ),
                ))),
      ),
    );
  }

  Widget _calendarSection() {
    return Expanded(
      child: Container(
        child: LayoutBuilder(builder: (BuildContext _context, BoxConstraints parentConstraints) {
          return SingleChildScrollView(
            child: Wrap(
                children: List.generate(
                    widget.days.length,
                    (index) => DayCell(
                        day: widget.days[index],
                        maxHeight: getCalendarHeight(context, maxHeight: parentConstraints.maxHeight),
                        maxWidth: parentConstraints.maxWidth - 1))),
          );
        }),
      ),
    );
  }

  Widget _summarySection() {
    return BlocBuilder<TransactionsCalendarBloc, TransactionsCalendarState>(builder: (context, state) {
      String currency = context.read<SettingsBloc>().state.currency;

      if (state is TransactionsCalendarLoaded) {
        return SummaryContainer(
          income: state.incomeSummary,
          expenses: state.expensesSummary,
          currency: currency,
        );
      }

      return SizedBox();
    });
  }

  double getCalendarHeight(BuildContext context, {required double maxHeight}) {
    bool isTablet = checkIfTablet(context);
    Orientation orientation = MediaQuery.of(context).orientation;

    double result;

    if (isTablet) {
      result = maxHeight;
    } else if (orientation == Orientation.portrait) {
      result = maxHeight;
    } else {
      result = MediaQuery.of(context).size.width;
    }

    return result;
  }
}
