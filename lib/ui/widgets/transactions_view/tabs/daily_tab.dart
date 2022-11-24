import 'package:flutter/material.dart';
import '../../daily_transactions_list.dart';

class DailyTab extends StatelessWidget {
  const DailyTab({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: DailyTransactionList(),
    );
  }
}
