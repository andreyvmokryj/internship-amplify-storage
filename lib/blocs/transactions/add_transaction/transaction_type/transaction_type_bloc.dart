import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';

part 'transaction_type_event.dart';
part 'transaction_type_state.dart';

class TransactionTypeBloc extends Bloc<TransactionTypeEvent, TransactionTypeState>{
  TransactionTypeBloc() : super(TransactionTypeState(TransactionType.Income));

  @override
  Stream<TransactionTypeState> mapEventToState(TransactionTypeEvent event) async* {
    if(event is TransactionSelectType){
      yield* _mapSelectTypeToState(event);
    }
  }

  Stream<TransactionTypeState> _mapSelectTypeToState(TransactionSelectType event) async* {
    yield TransactionTypeState(event.transactionType);
  }
}