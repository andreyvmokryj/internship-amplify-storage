import 'dart:core';

import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/multi_choice_account_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/multi_choice_modals/multi_choice_category_modal.dart';

enum MultiChoiceModalType{Account, Category}

Future<List?>? showMultiChoiceModal({required BuildContext context, required MultiChoiceModalType type}) {
  var modal;
  switch (type) {
    case MultiChoiceModalType.Account:
      modal = MultiChoiceAccountModal();
      break;
    case MultiChoiceModalType.Category:
      modal = MultiChoiceCategoryModal();
      break;
  }

  if(modal != null) {
    return showDialog<List>(
      context: context,
      builder: (context) => modal,
    );
  }

  return null;
}
