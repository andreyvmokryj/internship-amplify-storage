import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/accounts/account_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_scaffold.dart';
import 'package:radency_internship_project_2/ui/widgets/bottom_nav_bar.dart';
import 'package:settings_ui/settings_ui.dart';

class AccountsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      appBar: AppBar(
        title: Text(S.current.accounts),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return SettingsList(
            // backgroundColor: Colors.white,
            sections: [
              SettingsSection(
                tiles: state.accounts.map((e) =>
                  SettingsTile(
                    title: Text(e),
                    trailing: Container(
                      width: 0,
                    ),
                  ),
                ).toList(),
              )
            ]
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: (){

        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

}