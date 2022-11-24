import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_slider/transactions_slider_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_scaffold.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_transactions_header.dart';
import 'package:radency_internship_project_2/ui/widgets/bottom_nav_bar.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/transactions_content.dart';
import 'package:radency_internship_project_2/utils/routes.dart';

class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView>  with SingleTickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    int initialIndex = 0;
    var state = context.read<TransactionsSliderBloc>().state;
    if (state is TransactionsSliderLoaded) {
      switch (state.transactionsSliderMode) {
        case TransactionsSliderMode.daily:
          initialIndex = 0;
          break;
        case TransactionsSliderMode.calendar:
          initialIndex = 1;
          break;
        case TransactionsSliderMode.weekly:
          initialIndex = 2;
          break;
        case TransactionsSliderMode.monthly:
          initialIndex = 3;
          break;
        case TransactionsSliderMode.summary:
          initialIndex = 4;
          break;
      }
    }
    tabBarController = new TabController(length: 5, vsync: this, initialIndex: initialIndex);
    tabBarController.addListener(() {
      context.read<TransactionsSliderBloc>().add(TransactionsSliderModeChanged(index: tabBarController.index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
        appBar: AppBar(
          title: Text(S.current.home),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.of(context).pushNamed(Routes.searchExpensesPage);
              },
            ),
            SignOutButton(),
          ],
        ),
        header: DesignTransactionHeader(
          tabBarController: tabBarController,
        ),
        body: TransactionsContent(
          tabBarController: tabBarController,
        ),
        bottomNavigationBar: BottomNavBar());
  }
}
