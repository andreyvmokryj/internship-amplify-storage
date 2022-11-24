import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/navigation/navigation_bloc.dart';
import 'package:radency_internship_project_2/ui/add_transaction_menu.dart';

class BottomNavBar extends StatelessWidget {

  Widget build(BuildContext context) {
    final addButtonIndex = 2;
    var navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: S.current.stats,
            ),
            BottomNavigationBarItem(
              icon: floatingAddButton(context),
              label: ""
              // label: S.current.accounts,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: S.current.accounts,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: S.of(context).settings,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey[50],
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey,
          currentIndex: state.selectedPageIndex,
          onTap: (currentIndex) {
            if (currentIndex != addButtonIndex) {
              navigationBloc.add(SelectPage(currentIndex));
            }
          },
        );
      }
    );      
  }

  Widget floatingAddButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => AddTransactionMenu()
        );
      },
      child: Icon(
        Icons.add,
        size: 30,
      ));
  }
}