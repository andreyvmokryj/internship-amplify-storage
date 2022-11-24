import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/base_single_choice_modal.dart';

class SingleChoiceCategoryModal extends StatelessWidget{
  final List<String> categories;
  final onAddCallback;

  const SingleChoiceCategoryModal({Key? key, required this.categories, this.onAddCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ButtonStyleButton> contents = categories.map((element) => TextButton(
      onPressed: (){
        Navigator.of(context).pop(element);
      },
      child: Text(
        element,
        textAlign: TextAlign.center,
      )
    )).toList()
      + [
        TextButton(
          onPressed: onAddCallback,
          child: Text(S.current.addTransactionButtonAdd)
        )
      ];

    return BaseSingleChoiceModal(
      title: S.current.addTransactionCategoryFieldTitle,
      contents: contents,
      actions: [
        IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: (){},
          color: Colors.white,
          iconSize: 30,
        ),
      ],
    );
  }
}
