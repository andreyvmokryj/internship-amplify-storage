part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchAccounts extends AccountEvent{}

class SwitchSelectionForAccount extends AccountEvent{
  final String account;

  SwitchSelectionForAccount(this.account);

  @override
  List<Object> get props => [account];
}

class SwitchSelectionForAllAccounts extends AccountEvent{}

class ApplySelectedAccounts extends AccountEvent{}

class DiscardSelectedAccounts extends AccountEvent{}