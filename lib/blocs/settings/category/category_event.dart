part of 'category_bloc.dart';

abstract class CategoryEvent {
  CategoryEvent({this.settingName, this.listSettingValue});

  String? settingName;
  List<dynamic>? listSettingValue = List.empty();
}

class ChangeCategory implements CategoryEvent {
  ChangeCategory({this.settingName, this.listSettingValue});

  String? settingName;

  @override
  List? listSettingValue;

  @override
  int? settingValue;
}

class LoadCategoriesFromSharedPreferences implements CategoryEvent {
  @override
  List? listSettingValue;

  @override
  String? settingName;

  @override
  int? settingValue;
}

class ChangeCategoryCounter implements CategoryEvent {
  ChangeCategoryCounter({this.settingName, this.settingValue});

  int? settingValue;
  String? settingName;

  @override
  List? listSettingValue;
}

class SwitchSelectionForCategory extends CategoryEvent{
  final String category;

  SwitchSelectionForCategory(this.category);

  @override
  List<Object> get props => [category];
}

class SwitchSelectionForCategoryType extends CategoryEvent{
  final CategoryType categoryType;

  SwitchSelectionForCategoryType(this.categoryType);

  @override
  List<Object> get props => [categoryType];
}

class ApplySelectedCategories extends CategoryEvent{}

class DiscardSelectedCategories extends CategoryEvent{}

enum CategoryType {Income, Expense}