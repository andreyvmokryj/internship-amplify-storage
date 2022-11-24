import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textStyleOnboardingScreensMainText(context) {
  return GoogleFonts.openSans(
      textStyle: TextStyle(fontSize: 18, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.w400));
}

textStyleHeader({@required color}) {
  return GoogleFonts.openSans(
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3, color: color));
}

textStyleTransactionListAmount({double size = 16, Color color = Colors.grey, FontWeight fontWeight = FontWeight.w400}) {
  return GoogleFonts.nunito(
      textStyle: TextStyle(fontSize: size, fontWeight: fontWeight, letterSpacing: -0.3, color: color));
}

textStyleTransactionListCurrency(
    {double size = 16, Color? color = Colors.grey, FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(fontSize: size, fontWeight: fontWeight, letterSpacing: -0.3, color: color);
}

transactionsListDescriptionTextStyle(
    {double size = 16, Color color = Colors.grey, FontWeight fontWeight = FontWeight.w400}) {
  return GoogleFonts.nunito(
      textStyle: TextStyle(fontSize: size, fontWeight: fontWeight, letterSpacing: -0.3, color: color));
}

TextStyle chartExpenseAmountTextStyle(BuildContext context) {
  return GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: Theme.of(context).textTheme.bodyText1?.color,
  );
}

TextStyle expenseDescriptionTextStyle(BuildContext context, {Color? optionalColor}) {
  return GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.3,
    color: optionalColor ?? Theme.of(context).textTheme.bodyText1?.color,
  );
}

TextStyle chartExpenseCurrencyTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.3,
    color: Theme.of(context).textTheme.bodyText1?.color,
  );
}

charts.TextStyleSpec chartLabelStyle(BuildContext context) {
  return charts.TextStyleSpec(
      fontFamily: 'Nunito',
      fontWeight: '600',
      fontSize: 16,
      color: charts.Color.fromOther(
          color: charts.Color(
        a: Theme.of(context).textTheme.bodyText1!.color!.alpha,
        b: Theme.of(context).textTheme.bodyText1!.color!.blue,
        r: Theme.of(context).textTheme.bodyText1!.color!.red,
        g: Theme.of(context).textTheme.bodyText1!.color!.green,
      )));
}

TextStyle addTransactionMenuTitleTextStyle() {
  return GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
  );
}

TextStyle addTransactionMenuItemTextStyle() {
  return GoogleFonts.nunito(
    textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
  );
}

TextStyle addTransactionMenuCancelButtonTextStyle() {
  return GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
  );
}

// Budget view
// ###
TextStyle budgetItemUnlimitedTitleStyle = GoogleFonts.nunito(
  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
);

TextStyle budgetItemUnlimitedExpenseAmountStyle = GoogleFonts.nunito(
  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
);

TextStyle budgetItemLimitedAndRemainingTitleStyle =
    GoogleFonts.nunito(textStyle: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold));

TextStyle budgetItemLimitedTotalBudgetAmountStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
));

TextStyle budgetItemLimitedIndicatorPercentageStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
));

TextStyle budgetItemLimitedExpenseAmountStyle({required bool isOverBudget, required BuildContext context}) {
  return GoogleFonts.nunito(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: isOverBudget ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
  ));
}

TextStyle budgetSummaryRemainingAmountStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
));
