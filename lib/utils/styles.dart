import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle tabTitleStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).primaryTextTheme.headline6?.color
  );
}

TextStyle expensesTabStyle(BuildContext context) {
  return TextStyle(fontSize: Theme.of(context).textTheme.bodyText1?.fontSize ?? 0 + 2, fontWeight: FontWeight.w600);
}

const regularTextStyle = TextStyle(
  fontSize: 16,
);

const addTransactionAvatarTextStyle = TextStyle(
  fontSize: 28,
);

TextStyle medium({Color? color, double size = 14}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontSize: size,
      fontWeight: FontWeight.w500);
}

TextStyle regular({Color? color, double? size, TextDecoration? decoration}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontSize: size ?? 14,
      fontWeight: FontWeight.w400,
      decoration: decoration);
}

var primaryColorsArray = [
  //"#FFFFFF", "#E25F4E", "#EB839A", "#5ABC7B", "#4896F4", "#4A4A4A", "#947EB0"
  "#947EB0", "#5ABC7B", "#4896F4", "#E25F4E",
];

abstract class CustomTheme {
  late String accentColor;
  late String primaryColorDark;
  late String primaryColorLight;
  String secondaryHeaderColor = '#202020';
}

class PurpleTheme implements CustomTheme {
  String accentColor = '#947EB0';
  String primaryColorDark = '#190933';
  String primaryColorLight = '#A3A5C3';
  String secondaryHeaderColor = '#202020';
}

class GreenTheme implements CustomTheme {
  String accentColor = '#5ABC7B';
  String primaryColorDark = '#47803D';
  String primaryColorLight = '#8CD388';
  String secondaryHeaderColor = '#202020';
}

class BlueTheme implements CustomTheme {
  String accentColor = "#4896F4";
  String primaryColorDark = '#0A76A4';
  String primaryColorLight = '#7FB3C9';
  String secondaryHeaderColor = '#202020';
}

class RedTheme implements CustomTheme {
  String accentColor = "#E25F4E";
  String primaryColorDark = '#B92F1E';
  String primaryColorLight = '#F17667';
  String secondaryHeaderColor = '#202020';
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

ThemeMode getThemeMode(pMode) {
  if (pMode == "light") {
    return ThemeMode.light;
  } else if (pMode == 'dark') {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

class Styles {
  static Color getAccentColor(bool darkTheme, String primaryLightColor) {
    return darkTheme ? HexColor(primaryLightColor) : primaryLightColor == "#FFFFFF" ? Colors.blue : HexColor(primaryLightColor);
  }

  static ThemeData themeData(BuildContext context, bool darkTheme, CustomTheme theme) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
      ),
      primaryColor: darkTheme ? Colors.black : HexColor(theme.accentColor),
      accentColor: getAccentColor(darkTheme, theme.accentColor),
      accentColorBrightness: darkTheme ? Brightness.dark : Brightness.light,
      backgroundColor: darkTheme ? Colors.black : HexColor("#F1F5FB"),
      cardColor: darkTheme ? HexColor("#151515") : Colors.white,
      canvasColor: darkTheme ? Colors.black : Colors.white,
      brightness: darkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: darkTheme ? ColorScheme.dark() : ColorScheme.light()),
      secondaryHeaderColor: darkTheme ? Colors.white : HexColor(theme.secondaryHeaderColor),
      primaryColorDark: HexColor(theme.primaryColorDark),
      primaryColorLight: HexColor(theme.primaryColorLight),
    );
  }
}



// ###
//

TextStyle elevatedButtonTitleStyle(BuildContext context, Color titleColor) {
  return TextStyle(color: titleColor, fontSize: 18);
}

TextStyle addTransactionFormTitleTextStyle(BuildContext context) {
  return TextStyle(color: Colors.grey, fontSize: 16);
}

TextStyle addTransactionBottomModalSheetButtonsTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).textTheme.bodyText1?.color,
    fontSize: 18,
  );
}

TextStyle addTransactionElevatedButtonTitleStyle(BuildContext context, [Color? titleColor]) {
  return TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600);
}

InputDecoration addTransactionFormFieldDecoration(context, {String? hintText, Widget? prefixIcon, double? prefixWidth, bool focused = false}) {
  return InputDecoration(
    helperText: '',
    prefixIcon: prefixIcon,
    prefixIconConstraints: BoxConstraints(minWidth: prefixWidth ?? 20, minHeight: 0),
    hintText: hintText,
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1
      )
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 2
      )
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: focused ? 2 : 1
      )
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).errorColor,
        width: focused ? 2 : 1
      )
    ),
  );
}

TextStyle addTransactionFormInputTextStyle() {
  return TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w600,
    fontSize: 16);
}

BoxDecoration addTransactionFormBodyStyle() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(48),
      topRight: Radius.circular(48)));
}

// Search transactions view
// ###

TextStyle searchModalTitleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600
  );
}

TextStyle buttonTitleStyle(BuildContext context, [Color? titleColor]) {
  return TextStyle(color: titleColor ?? Colors.black, fontSize: 18);
}


// Currency modal
const currencyModalTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const currencyModalSubtitleStyle = TextStyle(
  fontSize: 15,
);