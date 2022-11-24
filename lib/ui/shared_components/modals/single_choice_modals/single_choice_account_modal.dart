import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/base_single_choice_modal.dart';

class SingleChoiceAccountModal extends StatelessWidget{
  final List<String> accounts;
  final onAddCallback;

  const SingleChoiceAccountModal({Key? key, required this.accounts, this.onAddCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ButtonStyleButton> contents = accounts.map((element) => TextButton(
      onPressed: (){
        Navigator.of(context).pop(element);
      },
      child: Text(element)
    )).toList()
      + [
        TextButton(
          onPressed: onAddCallback,
          child: Text(S.current.addTransactionButtonAdd)
        )
      ];

    return BaseSingleChoiceModal(
      title: S.current.transactionsTabTitleAccount,
      contents: contents,
      actions: [
        IconButton(
          icon: Icon(Icons.copy),
          onPressed: (){},
          color: Colors.white,
          iconSize: 30,
        ),
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
