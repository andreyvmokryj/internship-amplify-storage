import 'dart:ui';

class ChartCategoryDetails {
  final String categoryName;
  double percents;
  double value;
  Color? color;

  ChartCategoryDetails({required this.categoryName, this.percents = 0, this.value = 0, this.color});
}