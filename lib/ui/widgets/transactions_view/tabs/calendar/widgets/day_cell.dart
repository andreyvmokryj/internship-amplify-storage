import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/local_models/calendar_day.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/tabs/calendar/widgets/calendar_day_dialog.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class DayCell extends StatelessWidget {
  const DayCell({Key? key, required this.day, required this.maxHeight, required this.maxWidth}) : super(key: key);

  final CalendarDay day;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    String currency = context.read<SettingsBloc>().state.currency;

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CalendarDayDialog(
                day: day,
                currencySymbol: getCurrencySymbol(currency),
              );
            });
      },
      child: Container(
        width: maxWidth / 7,
        height: maxHeight / 6,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: AutoSizeText(
                day.displayedDate,
                presetFontSizes: [22, 20, 18, 17, 16, 15, 14, 13, 12, 11, 10],
                textAlign: TextAlign.end,
                maxLines: 1,
                style: expenseDescriptionTextStyle(context, optionalColor: day.isActive ? null : Colors.grey),
              ),
            ),
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (BuildContext _context, BoxConstraints constraints) {
                  return Column(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // //mainAxisSize: MainAxisSize.min,
                    children: [
                      value(
                        context: context,
                        value: day.incomeAmount,
                        color: Theme.of(context).primaryColorLight,
                        height: constraints.maxHeight / 3,
                        maxWidth: constraints.maxWidth,
                      ),
                      value(
                        context: context,
                        value: day.expensesAmount,
                        color: Theme.of(context).primaryColorDark,
                        height: constraints.maxHeight / 3,
                        maxWidth: constraints.maxWidth,
                      ),
                      value(
                        context: context,
                        value: day.transferAmount,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        height: constraints.maxHeight / 3,
                        maxWidth: constraints.maxWidth,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget value({
    required BuildContext context,
    required double value,
    Color? color,
    required double height,
    required double maxWidth,
  }) {
    if (value == 0.0) {
      return SizedBox();
    }

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: height, maxWidth: maxWidth),
            child: AutoSizeText(
              value.toStringAsFixed(2) ?? '',
              presetFontSizes: [24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7],
              style: TextStyle(color: color),
              overflowReplacement: Text('...', style: TextStyle(color: color)),
              textAlign: TextAlign.end,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
