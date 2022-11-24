import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:radency_internship_project_2/local_models/budget/category_budget.dart';
import 'package:radency_internship_project_2/providers/hive/hive_provider.dart';
import 'package:radency_internship_project_2/repositories/repository.dart';

class BudgetsRepository extends IRepository<CategoryBudget> {
  BudgetsRepository();

  @override
  Future<void> add(CategoryBudget categoryBudget) async {
    // In case of Hive "add" works the same way as "update"
    Box<CategoryBudget> box = await HiveProvider().openBudgetsBox();
    await box.add(categoryBudget);
  }

  @override
  Future<void> delete({String? categoryName}) async {
    Box<CategoryBudget> box = await HiveProvider().openBudgetsBox();

    int index = box.values.toList().indexWhere((element) => element.category == categoryName);

    if (index != -1) box.deleteAt(index);
  }

  @override
  Future<CategoryBudget> find({String? categoryName}) async {
    CategoryBudget categoryBudget;

    Box<CategoryBudget> box = await HiveProvider().openBudgetsBox();

    categoryBudget = box.values.firstWhere((element) => element.category == categoryName);

    return categoryBudget;
  }

  @override
  Future<void> update({CategoryBudget? categoryBudget}) async {
    Box<CategoryBudget> box = await HiveProvider().openBudgetsBox();
    await box.add(categoryBudget!);
  }

  Future<List<CategoryBudget>> findAll() async {
    List<CategoryBudget> budgets = [];

    Box<CategoryBudget> box = await HiveProvider().openBudgetsBox();

    budgets.addAll(box.values);

    return budgets;
  }
}
