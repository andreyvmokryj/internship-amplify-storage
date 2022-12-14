import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radency_internship_project_2/blocs/accounts/account_notifier.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/base_multi_choice_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/item_row.dart';

class MultiChoiceAccountModal extends ConsumerStatefulWidget{

  @override
  _MultiChoiceAccountModalState createState() => _MultiChoiceAccountModalState();
}

class _MultiChoiceAccountModalState extends ConsumerState<MultiChoiceAccountModal> {
  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountsProvider);
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

  Widget _buildAllRow(bool selected){
    return ItemRow(
      selected: selected,
      title: S.current.searchExpensesAllCheckbox,
      onTap: (){
        ref.read(accountsProvider.notifier).switchSelectionForAllAccounts();
      }
    );
  }

  Widget _buildAccountRow(String account, bool selected){
    return ItemRow(
      selected: selected,
      title: account,
      onTap: (){
        ref.read(accountsProvider.notifier).switchSelectionForAccount(account);
      }
    );
  }

  void onOkCallback(){
    ref.read(accountsProvider.notifier).applySelectedAccounts();
    Navigator.of(context).pop();
  }

  void onCanelCallback(){
    ref.read(accountsProvider.notifier).discardSelectedAccounts();
    Navigator.of(context).pop();
  }
}