import 'dart:core';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/amount/amount_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/single_choice_account_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/single_choice_category_modal.dart';

enum SingleChoiceModalType{Account, Category, Amount}

Future<String?>? showSingleChoiceModal({required BuildContext context, required SingleChoiceModalType type, List<String> values = const [], onAddCallback, updateAmountCallback, String title = "", bool showSubcurrencies = true}) {
  var modal;
  switch (type) {
    case SingleChoiceModalType.Account:
      modal = SingleChoiceAccountModal(
        onAddCallback: onAddCallback,
        accounts: values,
      );
      break;
    case SingleChoiceModalType.Category:
      modal = SingleChoiceCategoryModal(
        onAddCallback: onAddCallback,
        categories: values,
      );
      break;
    case SingleChoiceModalType.Amount:
      modal = AmountModal(
        onUpdateCallback: updateAmountCallback,
        title: title,
        showSubcurrencies: showSubcurrencies,
      );
      break;
  }

  if (modal != null) {
    return showMaterialModalBottomSheet(
      barrierColor: Colors.transparent,
      expand: false,
      context: context,
      builder: (context) => modal,
    );
  }
  return null;
}
