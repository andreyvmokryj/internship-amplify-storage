part of 'sub_currency_bloc.dart';

abstract class SubCurrencyState extends Equatable{
  final List<Currency> currencies;
  final Currency? selectedSubCurrency;

  SubCurrencyState({this.currencies = const [], this.selectedSubCurrency});

  @override
  List<Object> get props => [...currencies, selectedSubCurrency ?? ""];
}

class SubCurrencyInitial extends SubCurrencyState{}

class SubCurrencyLoading extends SubCurrencyState{}

class SubCurrencyLoaded extends SubCurrencyState{
  final List<Currency> currencies;
  final Currency? selectedSubCurrency;

  SubCurrencyLoaded({this.currencies = const [], this.selectedSubCurrency}) : super(
    currencies: currencies,
    selectedSubCurrency: selectedSubCurrency,
  );

  @override
  List<Object> get props => [...currencies, selectedSubCurrency ?? ""];
}