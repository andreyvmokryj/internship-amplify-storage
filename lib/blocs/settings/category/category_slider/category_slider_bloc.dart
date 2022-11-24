import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_slider_event.dart';

part 'category_slider_state.dart';

enum CategorySliderMode { income, expense, undefined }

class CategorySliderBloc extends Bloc<CategorySliderEvent, CategorySliderState> {
  CategorySliderBloc() : super(CategorySliderInitial());

  CategorySliderMode _currentTransactionsSliderMode = CategorySliderMode.undefined;

  @override
  Stream<CategorySliderState> mapEventToState(
    CategorySliderEvent event,
  ) async* {
    if (event is CategorySliderInitialize) {
      yield* _mapTransactionsSliderInitializeToState();
    } else if (event is CategorySliderModeChanged) {
      yield* _mapTransactionsSliderModeChangedToState(tabIndex: event.index);
    }
  }

  Stream<CategorySliderState> _mapTransactionsSliderInitializeToState() async* {
    _currentTransactionsSliderMode = CategorySliderMode.income;
    yield CategorySliderLoaded(categorySliderMode: _currentTransactionsSliderMode);
  }

  Stream<CategorySliderState> _mapTransactionsSliderModeChangedToState({required int tabIndex}) async* {
    switch (tabIndex) {
      case 0:
        _currentTransactionsSliderMode = CategorySliderMode.income;
        break;
      case 1:
        _currentTransactionsSliderMode = CategorySliderMode.expense;
        break;
      default:
        _currentTransactionsSliderMode = CategorySliderMode.undefined;
        break;
    }

    yield CategorySliderLoaded(categorySliderMode: _currentTransactionsSliderMode);
  }
}
