import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:radency_internship_project_2/providers/hive/hive_types.dart';

part 'category_budget.g.dart';

@HiveType(typeId: HiveTypes.CATEGORY_BUDGET)
class CategoryBudget {
  @HiveField(0)
  String category;
  @HiveField(1)
  double budgetValue;

  CategoryBudget({required this.category, required this.budgetValue});
}