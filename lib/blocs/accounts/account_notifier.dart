import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radency_internship_project_2/blocs/accounts/account_state.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier() : super(AccountState(
    accounts: [],
    selectedAccounts: [],
    appliedAccounts: [],
  ));

  void fetchAccounts() {
    state = AccountState(
      accounts: ['Cash', 'Bank accounts', 'Credit cards', ],
      selectedAccounts: [],
      appliedAccounts: [],
    );
  }

  void switchSelectionForAccount(String account) {
    List<String> selectedAccounts = List.from(state.selectedAccounts);
    if(selectedAccounts.contains(account)){
      selectedAccounts.remove(account);
    }
    else {
      selectedAccounts.add(account);
    }

    state = AccountState(
        accounts: state.accounts,
        selectedAccounts: selectedAccounts,
        appliedAccounts: state.appliedAccounts,
    );
  }

  void switchSelectionForAllAccounts() {
    bool select = state.accounts.length != state.selectedAccounts.length;

    state = AccountState(
      accounts: state.accounts,
      selectedAccounts: select  ? List.from(state.accounts) : [],
      appliedAccounts: state.appliedAccounts,
    );
  }

  void applySelectedAccounts() {
    state = AccountState(
      accounts: state.accounts,
      selectedAccounts: state.selectedAccounts,
      appliedAccounts: List.from(state.selectedAccounts),
    );
  }

  void discardSelectedAccounts() {
    state = AccountState(
      accounts: state.accounts,
      selectedAccounts: List.from(state.appliedAccounts),
      appliedAccounts: state.appliedAccounts,
    );
  }
}

final accountsProvider = StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier()..fetchAccounts();
});