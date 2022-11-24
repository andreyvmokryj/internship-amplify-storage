import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sub_currency_event.dart';
part 'sub_currency_state.dart';

class SubCurrencyBloc extends Bloc<SubCurrencyEvent, SubCurrencyState>{
  SubCurrencyBloc() : super(SubCurrencyInitial());

  @override
  Stream<SubCurrencyState> mapEventToState(SubCurrencyEvent event) async* {
    if(event is SubCurrencyInitialize){
      yield* _mapInitializeToState(event);
    }
    if(event is SubCurrencyFetchAvailableCurrencies){
      yield* _mapFetchAvailableCurrenciesToState(event);
    }
    if(event is SubCurrencySelectCurrency){
      yield* _mapSelectCurrencyToState(event);
    }
    if(event is SubCurrencyAddCurrency){
      yield* _mapAddCurrencyToState(event);
    }
  }

  Stream<SubCurrencyState> _mapInitializeToState(SubCurrencyInitialize event) async* {
    add(SubCurrencyFetchAvailableCurrencies());
  }

  Stream<SubCurrencyState> _mapFetchAvailableCurrenciesToState(SubCurrencyFetchAvailableCurrencies event) async* {
    yield SubCurrencyLoading();

    //TODO: implement endpoint

    yield SubCurrencyLoaded(
      currencies: [],
      selectedSubCurrency: null,
    );
  }

  Stream<SubCurrencyState> _mapSelectCurrencyToState(SubCurrencySelectCurrency event) async* {
    yield SubCurrencyLoaded(
      currencies: state.currencies,
      selectedSubCurrency: event.currency,
    );
  }

  Stream<SubCurrencyState> _mapAddCurrencyToState(SubCurrencyAddCurrency event) async* {
    List<Currency> currencies = List.from(state.currencies);
    if(!(currencies.contains(event.currency))) {
      currencies.add(event.currency);
    }

    //TODO: implement save endpoint

    yield SubCurrencyLoaded(
      currencies: currencies,
      selectedSubCurrency: null,
    );
  }
}