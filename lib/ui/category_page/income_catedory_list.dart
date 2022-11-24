import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_bloc.dart';
import 'category_page_common.dart';

class IncomeCategoriesPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => IncomeCategoriesPage());
  }

  @override
  Widget build(BuildContext context) {
    return buildReorderedCategoryList(context, incomeList);
  }
}