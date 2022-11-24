import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}

bool checkIfTablet(BuildContext context) {
  bool isTablet = MediaQuery.of(context).size.shortestSide > 550 ? true : false;
  return isTablet;
}
