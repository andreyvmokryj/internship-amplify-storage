import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/navigation/navigation_bloc.dart';
import 'package:radency_internship_project_2/ui/accounts_page/accounts_view.dart';
import 'package:radency_internship_project_2/ui/transactions_view.dart';
import 'package:radency_internship_project_2/ui/settings_page.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/stats_view.dart';

class HomePage extends StatelessWidget {
  Widget choosePageView(selectedPageIndex) {
    switch (selectedPageIndex) {
      case 0:
        return TransactionsView();

      case 1:
        return StatsView();

      case 3:
        return AccountsView();

      case 4:
        return SettingsPage();

      default:
        return TransactionsView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) => choosePageView(state.selectedPageIndex));
  }
}
