import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

Widget buildIncomeText(context, String currency, double value) {
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(children: [
      TextSpan(
          text: currency,
          style: textStyleTransactionListCurrency(
              size: 20, color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w700)),
      TextSpan(
          text: ' ${value.toStringAsFixed(2) ?? ''}',
          style: textStyleTransactionListAmount(
              size: 20, color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w700))
    ]),
  );
}

Widget buildOutcomeText(context, String currency, double value) {
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(children: [
      TextSpan(
          text: currency,
          style: textStyleTransactionListCurrency(
              size: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700)),
      TextSpan(
        text: ' ${value.toStringAsFixed(2) ?? ''}',
        style: textStyleTransactionListAmount(
            size: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),
      )
    ]),
  );
}
