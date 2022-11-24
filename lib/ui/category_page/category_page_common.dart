import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
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
  return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
    List<CategoryItemData> categoryItems;

    if (categoriesType == incomeList) {
      categoryItems = state.incomeCategories;
    } else {
      categoryItems = state.expensesCategories;
    }

    int _indexOfKey(Key key) {
      return categoryItems.indexWhere((CategoryItemData d) => d.key == key);
    }

    bool _reorderCallback(Key item, Key newPosition) {
      int draggingIndex = _indexOfKey(item);
      int newPositionIndex = _indexOfKey(newPosition);

      final draggedItem = categoryItems[draggingIndex];
      categoryItems.removeAt(draggingIndex);
      categoryItems.insert(newPositionIndex, draggedItem);

      context.read<CategoryBloc>().add(ChangeCategory(settingName: categoriesType, listSettingValue: categoryItems));

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            categoriesType == incomeList ? Text(S.current.incomeCategoryTitle) : Text(S.current.expensesCategoryTitle),
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
      body: ReorderableList(
        onReorder: _reorderCallback,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          CategoryItem(
                            data: categoryItems[index],
                            categoryType: categoriesType,
                          ),
                          Divider(height: 1)
                        ],
                      );
                    },
                    childCount: categoryItems.length,
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        heroTag: Hero(tag: 'addCategoryFAB', child: Icon(Icons.add),),
        onPressed: () {
          Navigator.pushNamed(context, Routes.newCategoryPage, arguments: NewCategoryPageArguments(categoriesType));
        },
        child: Icon(Icons.add),
      ),
    );
  });
}

class CategoryItem extends StatelessWidget {
  CategoryItem({required this.data, required this.categoryType});

  final CategoryItemData data;
  final String categoryType;

  String newCategoryName = "";

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy || state == ReorderableItemState.dragProxyFinished) {
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(color: placeholder ? null : Colors.white);
    }

    return DelayedReorderableListener(
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, blocState) {
        List<CategoryItemData> categoryItems;

        if (categoryType == incomeList)
          categoryItems = blocState.incomeCategories;
        else
          categoryItems = blocState.expensesCategories;

        return Container(
          decoration: decoration,
          child: SafeArea(
              top: false,
              bottom: false,
              child: Opacity(
                opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
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
                        categoryItems.remove(data);

                        context
                            .read<CategoryBloc>()
                            .add(ChangeCategory(settingName: categoryType, listSettingValue: categoryItems));
                      }),
                      _buildExpandedEditableText(context),
                      // Triggers the reordering
                      _buildActionIcon(context, categoryItems),
                      _buildReorderIcon(context)
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }

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

  Widget _buildReorderIcon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Icon(
        Icons.reorder,
        color: Colors.grey,
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
    return ReorderableItem(key: data.key, childBuilder: _buildChild);
  }
}
