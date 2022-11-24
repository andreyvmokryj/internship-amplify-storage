import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/utils/forex_service.dart';

part 'forex_event.dart';
part 'forex_state.dart';

class ForexBloc extends Bloc<ForexEvent, ForexState>{
  ForexBloc() : super(ForexState(
    dateTime: DateTime.now(),
    forex: {}
  ));

  @override
  Stream<ForexState> mapEventToState(ForexEvent event) async* {
    if(event is ForexFetchData){
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<ForexState> _mapFetchDataToState(ForexFetchData event) async* {
    yield ForexStateLoading(dateTime: state.dateTime);

    final dateTime = event.dateTime ?? state.dateTime;
    final forexMap = await ForexService().getExchangeRates(event.mainCurrencyCode, dateTime);
    yield ForexState(
      forex: forexMap as Map<String, double>,
      dateTime: dateTime,
    );
  }
}