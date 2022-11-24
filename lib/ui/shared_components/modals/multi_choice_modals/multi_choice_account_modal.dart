import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/accounts/account_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/base_multi_choice_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/item_row.dart';

class MultiChoiceAccountModal extends StatefulWidget{

  @override
  _MultiChoiceAccountModalState createState() => _MultiChoiceAccountModalState();
}

class _MultiChoiceAccountModalState extends State<MultiChoiceAccountModal> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, accountState) {
        bool selected = accountState.accounts.length == accountState.selectedAccounts.length;

        return BaseMultiChoiceModal(
          title: S.current.accounts,
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildAllRow(selected),
                  Divider(
                    thickness: 1.1,
                  ),
                ]
                + accountState.accounts.expand((e) => [
                    _buildAccountRow(e, accountState.selectedAccounts.contains(e)),
                    Divider(
                      thickness: 1.1,
                    ),
                  ]).toList(),
              ),
            ),
          ),
          onOKCallback: onOkCallback,
          onCancelCallback: onCanelCallback,
        );
      }
    );
  }

  Widget _buildAllRow(bool selected){
    return ItemRow(
      selected: selected,
      title: S.current.searchExpensesAllCheckbox,
      onTap: (){
        BlocProvider.of<AccountBloc>(context).add(SwitchSelectionForAllAccounts());
      }
    );
  }

  Widget _buildAccountRow(String account, bool selected){
    return ItemRow(
      selected: selected,
      title: account,
      onTap: (){
        BlocProvider.of<AccountBloc>(context).add(SwitchSelectionForAccount(account));
      }
    );
  }

  void onOkCallback(){
    BlocProvider.of<AccountBloc>(context).add(ApplySelectedAccounts());
    Navigator.of(context).pop();
  }

  void onCanelCallback(){
    BlocProvider.of<AccountBloc>(context).add(DiscardSelectedAccounts());
    Navigator.of(context).pop();
  }
}