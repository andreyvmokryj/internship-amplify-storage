import 'dart:async';

import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(SelectedPageState(0));

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if(event is SelectPage) {
      yield SelectedPageState(event.selectedPageIndex);
    }
  }
}
