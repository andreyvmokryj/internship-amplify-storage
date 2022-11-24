part of 'sub_currency_bloc.dart';

abstract class SubCurrencyEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SubCurrencyInitialize extends SubCurrencyEvent{}

class SubCurrencyFetchAvailableCurrencies extends SubCurrencyEvent{}

class SubCurrencySelectCurrency extends SubCurrencyEvent{
  final Currency? currency;

  SubCurrencySelectCurrency(this.currency);

  @override
  List<Object> get props => [currency ?? ""];
}

class SubCurrencyAddCurrency extends SubCurrencyEvent{
  final Currency currency;

  SubCurrencyAddCurrency(this.currency);

  @override
  List<Object> get props => [currency];
}