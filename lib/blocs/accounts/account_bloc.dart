import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState>{
  AccountBloc() : super(AccountState(
    accounts: [],
    selectedAccounts: [],
    appliedAccounts: [],
  ));

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if(event is FetchAccounts){
      yield* _mapFetchAccountsToState(event);
    }

    if(event is SwitchSelectionForAccount){
      yield* _mapSwitchSelectionForAccountToState(event);
    }

    if(event is SwitchSelectionForAllAccounts){
      yield* _mapSwitchSelectionForAllAccountsToState(event);
    }

    if(event is ApplySelectedAccounts){
      yield* _mapApplySelectedAccountsToState(event);
    }

    if(event is DiscardSelectedAccounts){
      yield* _mapDiscardSelectedAccountsToState(event);
    }
  }

  Stream<AccountState> _mapFetchAccountsToState(FetchAccounts event) async* {
    //TODO: implement fetch endpoint
    yield AccountState(
      accounts: ['Cash', 'Bank accounts', 'Credit cards', ],
      selectedAccounts: [],
      appliedAccounts: [],
    );
  }

  Stream<AccountState> _mapSwitchSelectionForAccountToState(SwitchSelectionForAccount event)async* {
    List<String> selectedAccounts = List.from(state.selectedAccounts);
    if(selectedAccounts.contains(event.account)){
      selectedAccounts.remove(event.account);
    }
    else {
      selectedAccounts.add(event.account);
    }

    yield AccountState(
      accounts: state.accounts,
      selectedAccounts: selectedAccounts,
      appliedAccounts: state.appliedAccounts,
    );
  }

  Stream<AccountState> _mapSwitchSelectionForAllAccountsToState(SwitchSelectionForAllAccounts event) async* {
    bool select = state.accounts.length != state.selectedAccounts.length;

    yield AccountState(
      accounts: state.accounts,
      selectedAccounts: select  ? List.from(state.accounts) : [],
      appliedAccounts: state.appliedAccounts,
    );
  }

  Stream<AccountState> _mapApplySelectedAccountsToState(ApplySelectedAccounts event) async* {
    yield AccountState(
      accounts: state.accounts,
      selectedAccounts: state.selectedAccounts,
      appliedAccounts: List.from(state.selectedAccounts),
    );
  }

  Stream<AccountState> _mapDiscardSelectedAccountsToState(DiscardSelectedAccounts event) async* {
    yield AccountState(
      accounts: state.accounts,
      selectedAccounts: List.from(state.appliedAccounts),
      appliedAccounts: state.appliedAccounts,
    );
  }
}