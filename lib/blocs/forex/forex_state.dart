part of 'forex_bloc.dart';

class ForexState extends Equatable{
  final DateTime dateTime;
  final Map<String, double>? forex;

  ForexState({required this.dateTime, this.forex});

  @override
  List<Object> get props => [dateTime];
}

class ForexStateLoading extends ForexState{
  final DateTime dateTime;

  ForexStateLoading({required this.dateTime}):super(
    dateTime: dateTime,
  );
}
