import 'dart:ui';

class ChartSection {
  final String categoryName;
  double percents;
  Color? color;

  ChartSection({required this.categoryName, this.percents = 0, this.color});
}
