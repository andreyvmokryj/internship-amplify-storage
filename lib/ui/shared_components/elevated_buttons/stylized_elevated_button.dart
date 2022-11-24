import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class StylizedElevatedButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Function? onPressed;

  StylizedElevatedButton(
      {required this.child, this.backgroundColor = Colors.white, required this.onPressed, this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => getColor(states, backgroundColor)),
          foregroundColor: MaterialStateProperty.all<Color>(
              foregroundColor ?? Theme.of(context).colorScheme.secondary),
          textStyle: MaterialStateProperty.all<TextStyle>(addTransactionElevatedButtonTitleStyle(
              context, foregroundColor ?? Theme.of(context).colorScheme.secondary)),
          // side: MaterialStateProperty.all<BorderSide>(
          //   BorderSide(width: 1, color: foregroundColor == null ? Theme.of(context).accentColor : foregroundColor),
          // ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          shadowColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () {
        onPressed?.call();
      }
    );
  }

  Color getColor(Set<MaterialState> states, Color defaultColor) {
    if (states.any(<MaterialState>{
      MaterialState.disabled,
    }.contains)) {
      return Colors.grey;
    }
    return defaultColor;
  }
}
