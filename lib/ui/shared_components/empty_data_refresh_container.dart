import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/centered_text_container.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/stylized_elevated_button.dart';

class EmptyDataRefreshContainer extends StatelessWidget {
  const EmptyDataRefreshContainer({Key? key, required this.refreshCallback, required this.message}) : super(key: key);

  final String message;
  final Function refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CenteredTextContainer(text: message),
        StylizedElevatedButton(
          child: Text(S.current.refreshButtonText),
          onPressed: refreshCallback,
        ),
      ],
    );
  }
}
