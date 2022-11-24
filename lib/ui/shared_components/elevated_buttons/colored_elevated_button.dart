import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/stylized_elevated_button.dart';

class ColoredElevatedButton extends StatelessWidget {
  final Widget child;
  final Function? onPressed;

  ColoredElevatedButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.secondary;
    final foregroundColor = Theme.of(context).colorScheme.onSecondary;

    return StylizedElevatedButton(
      child: child,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: onPressed,
    );
  }
}
