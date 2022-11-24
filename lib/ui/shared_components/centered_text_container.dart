import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class CenteredTextContainer extends StatelessWidget {
  const CenteredTextContainer({required this.text, Key? key}) : super(key: key);

  final String text;
  final double containerWidthRatio = 0.8;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * containerWidthRatio),
        child: Text(
          text,
          style: transactionsListDescriptionTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
