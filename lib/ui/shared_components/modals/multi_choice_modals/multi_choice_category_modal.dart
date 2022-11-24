import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/category/category_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/base_multi_choice_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/category_view.dart';

class MultiChoiceCategoryModal extends StatefulWidget{
  @override
  _MultiChoiceCategoryModalState createState() => _MultiChoiceCategoryModalState();
}

class _MultiChoiceCategoryModalState extends State<MultiChoiceCategoryModal> {
  @override
  Widget build(BuildContext context) {
    return BaseMultiChoiceModal(
      title: S.current.addTransactionCategoryFieldTitle,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, categoryState){
          return CategoryView();
        },
      ),
      onOKCallback: onOkCallback,
      onCancelCallback: onCanelCallback,
    );
  }

  void onOkCallback(){
    BlocProvider.of<CategoryBloc>(context).add(ApplySelectedCategories());
    Navigator.of(context).pop();
  }

  void onCanelCallback(){
    BlocProvider.of<CategoryBloc>(context).add(DiscardSelectedCategories());
    Navigator.of(context).pop();
  }
}