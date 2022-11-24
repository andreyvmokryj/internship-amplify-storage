import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:collection/collection.dart';

final String emailRegExp =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,"
    r"253}[a-zA-Z0-9])?)*$";

final String phoneNumberRegExp = r'^(?:[+])?[0-9]{9,16}$';

final _moneyFormat = NumberFormat("#,###0.00");
String getMoneyFormatted(double value, {String? separator, String? comma}){
  return _moneyFormat.format(value).replaceAll(",", " ").replaceAll(".", ",");
}

String getWeekDayByNumber(int num, BuildContext context) {
  switch (num) {
    case 1:
      return S.current.mondayShort;
    case 2:
      return S.current.tuesdayShort;
    case 3:
      return S.current.wednesdayShort;
    case 4:
      return S.current.thursdayShort;
    case 5:
      return S.current.fridayShort;
    case 6:
      return S.current.saturdayShort;
    case 7:
      return S.current.sundayShort;
  }
  return 'None';
}

String getMonthByNumber(BuildContext context, int num) {
  switch (num) {
    case 1:
      return S.current.januaryShort;
    case 2:
      return S.current.februaryShort;
    case 3:
      return S.current.marchShort;
    case 4:
      return S.current.aprilShort;
    case 5:
      return S.current.mayShort;
    case 6:
      return S.current.juneShort;
    case 7:
      return S.current.julyShort;
    case 8:
      return S.current.augustShort;
    case 9:
      return S.current.septemberShort;
    case 10:
      return S.current.octoberShort;
    case 11:
      return S.current.novemberShort;
    case 12:
      return S.current.decemberShort;
  }
  return 'None';
}

String getCurrencySymbol(String currencyCode) {
  return CurrencyService().findByCode(currencyCode)?.symbol ?? '';
}

final String numberWithDecimalRegExp = r'[0-9.]';

final String moneyAmountEditRegExp = r'^[0-9]+(\.[0-9]{0,2})?$';

final String moneyAmountRegExp = r'^[0-9]+(\.[0-9]{1,2})?$';

String capitalizeFirstLetter(String s) {
  if (s.trim().isEmpty) return '';

  return '${s[0].toUpperCase()}${s.substring(1)}';
}

String capitalizeFirstLetterOfEachWord(String s) => s.split(" ").map((str) => capitalizeFirstLetter(str)).join(" ");

T? enumFromString<T>(List<T> values, String value) {
  return values.firstWhereOrNull((v) => v.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}
