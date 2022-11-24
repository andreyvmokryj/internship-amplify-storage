part of 'category_bloc.dart';

class CategoryState {
  CategoryState({required this.selectedCategories, required this.appliedCategories, required this.incomeCategories, this.nextIncomeCategoryId, required this.expensesCategories, this.nextExpenseCategoryId});

  final List<CategoryItemData> incomeCategories;
  final List<CategoryItemData> expensesCategories;
  final int? nextIncomeCategoryId;
  final int? nextExpenseCategoryId;

  final List<String> selectedCategories;
  final List<String> appliedCategories;
}
