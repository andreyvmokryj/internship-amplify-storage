import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

Widget buildFormFieldTitle(BuildContext context, {required String title}) {
  return Text(
    title,
    style: addTransactionFormTitleTextStyle(context),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}