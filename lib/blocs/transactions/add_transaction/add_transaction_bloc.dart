import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';

part 'add_transaction_event.dart';

part 'add_transaction_state.dart';

class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc({required this.transactionsRepository}) : super(AddTransactionInitial());

  final TransactionsRepository transactionsRepository;

  @override
  Stream<AddTransactionState> mapEventToState(
    AddTransactionEvent event,
  ) async* {
    if (event is AddTransactionInitialize) {
      yield* _mapAddTransactionInitializeToState();
    } else if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event.transaction, event.isAddingCompleted);
    }
  }

  Stream<AddTransactionState> _mapAddTransactionInitializeToState() async* {
    // TODO: fetch categories, accounts, etc.

    yield AddTransactionLoaded(
        incomeCategories: TempTransactionsValues().incomeCategories,
        expenseCategories: TempTransactionsValues().expenseCategories,
        accounts: TempTransactionsValues().accounts);
  }

  Stream<AddTransactionState> _mapAddTransactionToState(AppTransaction transaction, bool isAddingCompleted) async* {
    yield AddTransactionLoaded(
        incomeCategories: TempTransactionsValues().incomeCategories,
        expenseCategories: TempTransactionsValues().expenseCategories,
        accounts: TempTransactionsValues().accounts);

    transactionsRepository.add(transaction);

    if (isAddingCompleted) {
      yield AddTransactionSuccessfulAndCompleted();
    } else {
      yield (AddTransactionSuccessfulAndContinued());
    }

    yield AddTransactionLoaded(
        incomeCategories: TempTransactionsValues().incomeCategories,
        expenseCategories: TempTransactionsValues().expenseCategories,
        accounts: TempTransactionsValues().accounts);
  }
}
