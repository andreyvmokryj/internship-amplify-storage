import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_slider/category_slider_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/category_page/category_page_common.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/item_row.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget{
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>with SingleTickerProviderStateMixin  {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();

    int initialIndex = 0;
    CategorySliderState state = BlocProvider.of<CategorySliderBloc>(context).state;

    if(state is CategorySliderLoaded) {
      switch (state.categorySliderMode) {
        case CategorySliderMode.income:
          initialIndex = 0;
          break;
        case CategorySliderMode.expense:
          initialIndex = 1;
          break;
        default:
          initialIndex = 0;
          break;
      }
    }

    tabBarController = new TabController(length: 2, vsync: this, initialIndex: initialIndex);
    tabBarController.addListener(() {
      context.read<CategorySliderBloc>().add(CategorySliderModeChanged(index: tabBarController.index));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTabBar(context, tabBarController),
            Expanded(
              child: TabBarView(
                controller: tabBarController,
                children: [
                  _buildCategories(CategoryType.Income),
                  _buildCategories(CategoryType.Expense),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, TabController controller) {
    return Container(
      child: TabBar(
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal
        ),
        controller: controller,
        tabs: [
          Tab(
            child: Text(S.current.income),
          ),
          Tab(
            child: Text(S.current.expenses),
          ),
        ],
        indicatorColor: Theme.of(context).accentColor,
      ),
    );
  }

  // Widget _buildTabTitle(String localizedTitle) {
  //   return Text(
  //     localizedTitle,
  //     style: tabTitleStyle(context).copyWith(color: Colors.black),
  //   );
  // }

  Widget _buildCategories(CategoryType categoryType){
    final categoryState = BlocProvider.of<CategoryBloc>(context).state;

    List<CategoryItemData> typeCategories = [];
    if(categoryType == CategoryType.Income) {
      typeCategories = categoryState.incomeCategories;
    }
    if(categoryType == CategoryType.Expense) {
      typeCategories = categoryState.expensesCategories;
    }

    List<String> categories = typeCategories.map((e) => e.title).toList();
    List<String> selectedCategories = List.from(categoryState.selectedCategories);
    bool typeSelected = selectedCategories.where((element) => categories.contains(element)).length == categories.length;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildAllRow(typeSelected, categoryType),
          Divider(
            thickness: 1.1,
          ),
        ]
          + typeCategories.expand((e) => [
            _buildCategoryRow(e.title, categoryState.selectedCategories.contains(e.title)),
            Divider(
              thickness: 1.1,
            ),
          ]).toList(),
      ),
    );
  }

  Widget _buildAllRow(bool selected, CategoryType categoryType){
    return ItemRow(
      selected: selected,
      title: S.current.searchExpensesAllCheckbox,
      onTap: (){
        BlocProvider.of<CategoryBloc>(context).add(SwitchSelectionForCategoryType(categoryType));
      }
    );
  }

  Widget _buildCategoryRow(String category, bool selected){
    return ItemRow(
      selected: selected,
      title: category,
      onTap: (){
        BlocProvider.of<CategoryBloc>(context).add(SwitchSelectionForCategory(category));
      }
    );
  }
}