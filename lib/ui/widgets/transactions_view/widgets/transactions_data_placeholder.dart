import 'package:flutter/material.dart';

class TransactionsDataPlaceholder extends StatelessWidget {
  final String text;

  TransactionsDataPlaceholder({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(text),
      ),
    );
  }
}
