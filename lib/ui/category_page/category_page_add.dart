import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';

import '../widgets/bottom_nav_bar.dart';
import 'category_page_common.dart';

class NewCategoryPageArguments {
  final String categoriesType;

  NewCategoryPageArguments(this.categoriesType);
}

class NewCategoryPage extends StatelessWidget {
  var newCategoryName = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      final NewCategoryPageArguments args = ModalRoute.of(context)!.settings.arguments as NewCategoryPageArguments;
      final categoriesType = args.categoriesType;
      List<CategoryItemData> categoryItems;

      int nextItemId;

      if (categoriesType == incomeList) {
        categoryItems = state.incomeCategories;
        nextItemId = state.nextIncomeCategoryId ?? 0;
      } else {
        categoryItems = state.expensesCategories;
        nextItemId = state.nextExpenseCategoryId ?? 0;
      }

      return Scaffold(
          appBar: AppBar(title: Text(S.current.newCategory)),
          body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), child: buildCategoryEditText(context)),
              ColoredElevatedButton(
                onPressed: () {
                  if (newCategoryName.isNotEmpty) {
                    print(nextItemId.toString());
                    categoryItems.add(CategoryItemData(newCategoryName, ValueKey(nextItemId)));

                    context
                        .read<CategoryBloc>()
                        .add(ChangeCategory(listSettingValue: categoryItems, settingName: categoriesType));

                    context
                        .read<CategoryBloc>()
                        .add(ChangeCategoryCounter(settingValue: nextItemId + 1, settingName: categoriesType));

                    Navigator.of(context).pop();
                  }
                },
                child: Text(S.current.save),
              )
            ],
          ),
          bottomNavigationBar: BottomNavBar());
    });
  }

  Widget buildCategoryEditText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: S.current.categoryName, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        onChanged: (value) => newCategoryName = value,
      ),
    );
  }
}
