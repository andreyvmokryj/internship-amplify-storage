import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_calendar/transactions_calendar_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_daily/transactions_daily_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_monthly/transactions_monthly_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_slider/transactions_slider_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_summary/transactions_summary_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_weekly/transactions_weekly_bloc.dart';
import 'package:radency_internship_project_2/ui/widgets/slider.dart';

class TransactionsTabSlider extends StatefulWidget {
  TransactionsTabSlider();

  @override
  _TransactionsTabSliderState createState() => _TransactionsTabSliderState();
}

class _TransactionsTabSliderState extends State<TransactionsTabSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsSliderBloc, TransactionsSliderState>(builder: (context, state) {
      if (state is TransactionsSliderLoaded) {
        switch (state.transactionsSliderMode) {
          case TransactionsSliderMode.daily:
            return Center(child: _dailySlider(context));
          case TransactionsSliderMode.weekly:
            return Center(child: _weeklySlider(context));
          case TransactionsSliderMode.monthly:
            return Center(child: _monthlySlider(context));
          case TransactionsSliderMode.summary:
            return Center(child: _summarySlider(context));
          case TransactionsSliderMode.calendar:
            return Center(child: _calendarSlider(context));
        }
      }

      return SizedBox();
    });
  }
}

Widget _dailySlider(BuildContext context) {
  void Function() onDailyTransactionsBackPressed = () {
    return context.read<TransactionsDailyBloc>().add(TransactionsDailyGetPreviousMonthPressed());
  };

  void Function() onDailyTransactionsForwardPressed = () {
    return context.read<TransactionsDailyBloc>().add(TransactionsDailyGetNextMonthPressed());
  };

  return BlocBuilder<TransactionsDailyBloc, TransactionsDailyState>(builder: (context, state) {
    if (state is TransactionsDailyLoading)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onDailyTransactionsForwardPressed, onBackPressed: onDailyTransactionsBackPressed);

    if (state is TransactionsDailyLoaded)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onDailyTransactionsForwardPressed, onBackPressed: onDailyTransactionsBackPressed);

    return DateRangeSlider(content: '', onBackPressed: null, onForwardPressed: null);
  });
}

Widget _calendarSlider(BuildContext context) {
  void Function() onDailyTransactionsBackPressed = () {
    return context.read<TransactionsCalendarBloc>().add(TransactionsCalendarGetPreviousMonthPressed());
  };

  void Function() onDailyTransactionsForwardPressed = () {
    return context.read<TransactionsCalendarBloc>().add(TransactionsCalendarGetNextMonthPressed());
  };

  return BlocBuilder<TransactionsCalendarBloc, TransactionsCalendarState>(builder: (context, state) {
    if (state is TransactionsCalendarLoading)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onDailyTransactionsForwardPressed, onBackPressed: onDailyTransactionsBackPressed);

    if (state is TransactionsCalendarLoaded)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onDailyTransactionsForwardPressed, onBackPressed: onDailyTransactionsBackPressed);

    return DateRangeSlider(content: '', onBackPressed: null, onForwardPressed: null);
  });
}

Widget _weeklySlider(BuildContext context) {
  void Function() onWeeklyTransactionsBackPressed = () {
    return context.read<TransactionsWeeklyBloc>().add(TransactionsWeeklyGetPreviousMonthPressed());
  };

  void Function() onWeeklyTransactionsForwardPressed = () {
    return context.read<TransactionsWeeklyBloc>().add(TransactionsWeeklyGetNextMonthPressed());
  };

  return BlocBuilder<TransactionsWeeklyBloc, TransactionsWeeklyState>(builder: (context, state) {
    if (state is TransactionsWeeklyLoading)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onWeeklyTransactionsForwardPressed, onBackPressed: onWeeklyTransactionsBackPressed);

    if (state is TransactionsWeeklyLoaded)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString, onForwardPressed: onWeeklyTransactionsForwardPressed, onBackPressed: onWeeklyTransactionsBackPressed);

    return DateRangeSlider(content: '', onBackPressed: null, onForwardPressed: null);
  });
}

Widget _monthlySlider(BuildContext context) {
  void Function() onMonthlyTransactionsBackPressed = () {
    return context.read<TransactionsMonthlyBloc>().add(TransactionsMonthlyGetPreviousYearPressed());
  };

  void Function() onMonthlyTransactionsForwardPressed = () {
    return context.read<TransactionsMonthlyBloc>().add(TransactionsMonthlyGetNextYearPressed());
  };

  return BlocBuilder<TransactionsMonthlyBloc, TransactionsMonthlyState>(builder: (context, state) {
    if (state is TransactionsMonthlyLoading)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onForwardPressed: onMonthlyTransactionsForwardPressed,
          onBackPressed: onMonthlyTransactionsBackPressed);

    if (state is TransactionsMonthlyLoaded)
      return DateRangeSlider(
          content: state.sliderCurrentTimeIntervalString,
          onForwardPressed: onMonthlyTransactionsForwardPressed,
          onBackPressed: onMonthlyTransactionsBackPressed);

    return DateRangeSlider(content: '', onBackPressed: null, onForwardPressed: null);
  });
}

Widget _summarySlider(BuildContext context) {
  void Function() onSummaryTransactionsBackPressed = () {
    return context.read<TransactionsSummaryBloc>().add(TransactionsSummaryGetPreviousMonthPressed());
  };

  void Function() onSummaryTransactionsForwardPressed = () {
    return context.read<TransactionsSummaryBloc>().add(TransactionsSummaryGetNextMonthPressed());
  };

  return BlocBuilder<TransactionsSummaryBloc, TransactionsSummaryState>(builder: (context, state) {
    if (state is TransactionsSummaryLoading)
      return DateRangeSlider(content: state.sliderCurrentTimeIntervalString, onForwardPressed: onSummaryTransactionsForwardPressed, onBackPressed: onSummaryTransactionsBackPressed);

    if (state is TransactionsSummaryLoaded)
      return DateRangeSlider(content: state.sliderCurrentTimeIntervalString, onForwardPressed: onSummaryTransactionsForwardPressed, onBackPressed: onSummaryTransactionsBackPressed);

    return DateRangeSlider(content: '', onBackPressed: null, onForwardPressed: null);
  });
}


