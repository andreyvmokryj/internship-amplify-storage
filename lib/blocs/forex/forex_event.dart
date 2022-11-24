part of 'forex_bloc.dart';

abstract class ForexEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class ForexFetchData extends ForexEvent{
  final String mainCurrencyCode;
  final DateTime? dateTime;

  ForexFetchData(this.mainCurrencyCode, [this.dateTime]);

  @override
  List<Object> get props => [mainCurrencyCode, dateTime ?? ""];
}
