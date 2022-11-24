part of 'category_slider_bloc.dart';

abstract class CategorySliderEvent extends Equatable {
  const CategorySliderEvent();
}

class CategorySliderInitialize extends CategorySliderEvent {
  @override
  List<Object> get props => [];
}

class CategorySliderModeChanged extends CategorySliderEvent {
  final int index;

  CategorySliderModeChanged({required this.index});

  @override
  List<Object> get props => [index];
}
