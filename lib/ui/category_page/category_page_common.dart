import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/routes.dart';

import '../widgets/bottom_nav_bar.dart';
import 'category_page_add.dart';

class CategoryItemData {
  CategoryItemData(this.title, this.key);

  final Key key;
  String title;
  bool editMode = false;
}

Widget buildReorderedCategoryList(BuildContext context, String categoriesType) {
  GlobalKey<AnimatedListState> _key = GlobalKey();
  List<CategoryItemData> categoryItems;

  if (categoriesType == incomeList) {
    categoryItems = [...context
        .read<CategoryBloc>()
        .state
        .incomeCategories
    ];
  } else {
    categoryItems = [...context
        .read<CategoryBloc>()
        .state
        .expensesCategories
    ];
  }

  for (int i = 0; i < categoryItems.length; i++) {
    _key.currentState?.insertItem(i);
  }

  return Scaffold(
    appBar: AppBar(
      title:
      categoriesType == incomeList ? Text(S.current.incomeCategoryTitle) : Text(
          S.current.expensesCategoryTitle),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          categoryItems.forEach((element) {
            element.editMode = false;
          });
          Navigator.of(context).pop();
        },
      ),
    ),
    body: BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        List<CategoryItemData> newItems;
        if (categoriesType == incomeList) {
          newItems = [...state.incomeCategories];
        } else {
          newItems = [...state.expensesCategories];
        }

        if (categoryItems.length < newItems.length) {
          for (int i = 0; i < newItems.length; i++) {
            if (!categoryItems.contains(newItems[i])) {
              categoryItems.add(newItems[i]);
              _key.currentState?.insertItem(categoryItems.length - 1);
            }
          }
        }
        if (categoryItems.length > newItems.length) {
          categoryItems.removeWhere((element) => !newItems.contains(element));
        }
      },

      child: AnimatedList(
        key: _key,
        initialItemCount: categoryItems.length,
        itemBuilder: (context, index, animation) =>
            Column(
              children: [
                CategoryItem(
                  data: categoryItems[index],
                  categoryType: categoriesType,
                ),
                Divider(height: 1),
              ],
            ),
      ),
    ),
    bottomNavigationBar: BottomNavBar(),
    floatingActionButton: FloatingActionButton(
      heroTag: Hero(tag: 'addCategoryFAB', child: Icon(Icons.add),),
      onPressed: () {
        Navigator.pushNamed(context, Routes.newCategoryPage,
            arguments: NewCategoryPageArguments(categoriesType));
      },
      child: Icon(Icons.add),
    ),
  );
}

class CategoryItem extends StatelessWidget {
  CategoryItem({required this.data, required this.categoryType});

  final CategoryItemData data;
  final String categoryType;

  String newCategoryName = "";

  Widget _buildListIcon(BuildContext context, Widget icon, String tooltip, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildExpandedEditableText(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(3))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child: () {
              var widget = data.editMode
                  ? TextFormField(
                      initialValue: data.title,
                      decoration: InputDecoration(
                          labelText: S.current.categoryName,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                      onChanged: (value) {
                        newCategoryName = value;
                        print(newCategoryName);
                      })
                  : Text(data.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1);
              return widget;
            }(),
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon(BuildContext context, List<CategoryItemData> categoryItems) {
    return () {
      if (data.editMode) {
        return _buildListIcon(
            context,
            Icon(
              Icons.save,
              color: Colors.grey,
            ),
            S.current.save, () {
          if (newCategoryName.isNotEmpty) data.title = newCategoryName;
          data.editMode = false;
          context.read<CategoryBloc>().add(ChangeCategory(settingName: categoryType, listSettingValue: categoryItems));
        });
      } else {
        return _buildListIcon(
            context,
            Icon(
              Icons.edit,
              color: Colors.grey,
            ),
            S.current.edit, () {
          categoryItems.forEach((element) {
            element.editMode = false;
          });
          data.editMode = true;
          context.read<CategoryBloc>().add(ChangeCategory(settingName: categoryType, listSettingValue: categoryItems));
        });
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, blocState) {
      List<CategoryItemData> categoryItems;

      if (categoryType == incomeList)
        categoryItems = blocState.incomeCategories;
      else
        categoryItems = blocState.expensesCategories;

      return Container(
        child: SafeArea(
            top: false,
            bottom: false,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildListIcon(
                      context,
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      S.current.delete, () {
                        int _index = categoryItems.indexOf(data);
                    AnimatedList.of(context).removeItem(_index,
                            (_, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: Container(
                              color: Colors.black26,
                              child: CategoryItem(
                                data: data,
                                categoryType: "",
                              ),
                            ),
                          );
                        },
                        duration: const Duration(seconds: 1));
                    categoryItems.remove(data);
                    context
                        .read<CategoryBloc>()
                        .add(ChangeCategory(settingName: categoryType, listSettingValue: categoryItems));
                  }),
                  _buildExpandedEditableText(context),
                  _buildActionIcon(context, categoryItems),
                ],
              ),
            )),
      );
    });
  }
}
