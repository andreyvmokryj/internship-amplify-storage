import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/ui/category_page/category_page_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'category_event.dart';
part 'category_state.dart';

const String incomeList = "incomeList";
const String expensesList = "expensesList";

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  SharedPreferences? prefs;

  CategoryBloc() : super(CategoryState(
    incomeCategories: List.empty(),
    expensesCategories: List.empty(),
    selectedCategories: List.empty(),
    appliedCategories: List.empty()
  )) {
    add(LoadCategoriesFromSharedPreferences());
  }

  CategoryState changeCategory(String categoryType, List<CategoryItemData> items) {
    if (categoryType == incomeList) {
      return CategoryState(
        incomeCategories: items,
        expensesCategories: state.expensesCategories,
        nextIncomeCategoryId: state.nextIncomeCategoryId,
        nextExpenseCategoryId: state.nextExpenseCategoryId,
        selectedCategories: [],
        appliedCategories: [],
      );
    } else {
      return CategoryState(
        incomeCategories: state.incomeCategories,
        expensesCategories: items,
        nextIncomeCategoryId: state.nextIncomeCategoryId,
        nextExpenseCategoryId: state.nextExpenseCategoryId,
        selectedCategories: [],
        appliedCategories: [],
      );
    }
  }

  CategoryState changeCategoryCounter(String categoryType, int newValue) {
    if (categoryType == incomeList) {
      return CategoryState(
        incomeCategories: state.incomeCategories,
        expensesCategories: state.expensesCategories,
        nextIncomeCategoryId: newValue,
        nextExpenseCategoryId: state.nextExpenseCategoryId,
        selectedCategories: [],
        appliedCategories: [],
      );
    } else {
      return CategoryState(
        incomeCategories: state.incomeCategories,
        expensesCategories: state.expensesCategories,
        nextIncomeCategoryId: state.nextIncomeCategoryId,
        nextExpenseCategoryId: newValue,
        selectedCategories: [],
        appliedCategories: [],
      );
    }
  }

  CategoryState loadFromPreferences() {
    //TODO Impl SharedPrefs!
    var incomeListRaw = prefs!.getString(incomeList);
    var expensesListRaw = prefs!.getString(expensesList);
    var incomeId = prefs!.getInt(expensesList);
    var expensesId = prefs!.getInt(expensesList);

    var incomeLabels = TempTransactionsValues().incomeCategories;
    var incomeItems = [];
    for (int i = 0; i < incomeLabels.length; ++i) {
      String label = incomeLabels[i];
      incomeItems.add(CategoryItemData(label, ValueKey(i)));
    }

    var outcomeLabels = TempTransactionsValues().expenseCategories;
    var outcomeItems = [];
    for (int i = 0; i < outcomeLabels.length; ++i) {
      String label = outcomeLabels[i];
      outcomeItems.add(CategoryItemData(label, ValueKey(i)));
    }

    return CategoryState(
      incomeCategories: incomeItems.cast<CategoryItemData>(),
      expensesCategories: outcomeItems.cast<CategoryItemData>(),
      nextIncomeCategoryId: incomeLabels.length,
      nextExpenseCategoryId: outcomeLabels.length,
      selectedCategories: [],
      appliedCategories: [],
    );
  }

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is ChangeCategory) {
      yield changeCategory(event.settingName!, event.listSettingValue!.cast<CategoryItemData>());
    }

    if (event is ChangeCategoryCounter) {
      yield changeCategoryCounter(event.settingName!, event.settingValue!);
    }

    if (event is LoadCategoriesFromSharedPreferences) {
      prefs = await SharedPreferences.getInstance();

      yield loadFromPreferences();
    }

    if(event is SwitchSelectionForCategory) {
      yield* _mapSwitchSelectionForCategoryToState(event);
    }

    if(event is SwitchSelectionForCategoryType) {
      yield* _mapSwitchSelectionForCategoryTypeToState(event);
    }

    if(event is ApplySelectedCategories) {
      yield* _mapApplySelectedCategoriesToState(event);
    }

    if(event is DiscardSelectedCategories) {
      yield* _mapDiscardSelectedCategoriesToState(event);
    }
  }

  Stream<CategoryState> _mapSwitchSelectionForCategoryToState(SwitchSelectionForCategory event)async* {
    List<String> selectedCategories = List.from(state.selectedCategories);
    if(selectedCategories.contains(event.category)){
      selectedCategories.remove(event.category);
    }
    else {
      selectedCategories.add(event.category);
    }

    yield CategoryState(
      incomeCategories: state.incomeCategories,
      expensesCategories: state.expensesCategories,
      nextIncomeCategoryId: state.nextIncomeCategoryId,
      nextExpenseCategoryId: state.nextExpenseCategoryId,
      selectedCategories: selectedCategories,
      appliedCategories: state.appliedCategories,
    );
  }

  Stream<CategoryState> _mapSwitchSelectionForCategoryTypeToState(SwitchSelectionForCategoryType event) async* {
    List<String> typeCategories = [];
    if(event.categoryType ==  CategoryType.Income) {
      typeCategories = state.incomeCategories.map((e) => e.title).toList();
    }
    if(event.categoryType ==  CategoryType.Expense) {
      typeCategories = state.expensesCategories.map((e) => e.title).toList();
    }

    List<String> selectedCategories = List.from(state.selectedCategories);
    bool shouldBeSelected = !(selectedCategories.where((element) => typeCategories.contains(element)).length == typeCategories.length);

    List<String> newCategories = List.from(state.selectedCategories);

    if (shouldBeSelected){
      typeCategories.forEach((element) {
        if(!(newCategories.contains(element))) {
          newCategories.add(element);
        }
      });
    }
    else {
      typeCategories.forEach((element) {
        if(newCategories.contains(element)) {
          newCategories.remove(element);
        }
      });
    }

    yield CategoryState(
      incomeCategories: state.incomeCategories,
      expensesCategories: state.expensesCategories,
      nextIncomeCategoryId: state.nextIncomeCategoryId,
      nextExpenseCategoryId: state.nextExpenseCategoryId,
      selectedCategories: newCategories,
      appliedCategories: state.appliedCategories,
    );
  }

  Stream<CategoryState> _mapApplySelectedCategoriesToState(ApplySelectedCategories event) async* {
    yield CategoryState(
      incomeCategories: state.incomeCategories,
      expensesCategories: state.expensesCategories,
      nextIncomeCategoryId: state.nextIncomeCategoryId,
      nextExpenseCategoryId: state.nextExpenseCategoryId,
      selectedCategories: state.selectedCategories,
      appliedCategories: List.from(state.selectedCategories),
    );
  }

  Stream<CategoryState> _mapDiscardSelectedCategoriesToState(DiscardSelectedCategories event) async* {
    yield CategoryState(
      incomeCategories: state.incomeCategories,
      expensesCategories: state.expensesCategories,
      nextIncomeCategoryId: state.nextIncomeCategoryId,
      nextExpenseCategoryId: state.nextExpenseCategoryId,
      selectedCategories: List.from(state.appliedCategories),
      appliedCategories: state.appliedCategories,
    );
  }
}
