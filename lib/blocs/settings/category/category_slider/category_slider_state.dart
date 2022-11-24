part of 'category_slider_bloc.dart';

abstract class CategorySliderState extends Equatable {
  const CategorySliderState();
}

class CategorySliderInitial extends CategorySliderState {
  @override
  List<Object> get props => [];
}

class CategorySliderLoading extends CategorySliderState {
  @override
  List<Object> get props => [];
}

class CategorySliderLoaded extends CategorySliderState {
  final CategorySliderMode categorySliderMode;

  CategorySliderLoaded({required this.categorySliderMode});

  @override
  List<Object> get props => [categorySliderMode];
}
