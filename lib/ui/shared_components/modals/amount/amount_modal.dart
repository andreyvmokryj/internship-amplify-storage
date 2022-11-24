import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/sub_currency/sub_currency_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/currencies_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/base_single_choice_modal.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class AmountModal extends StatelessWidget{
  final onUpdateCallback;
  final title;
  final bool showSubcurrencies;

  const AmountModal({Key? key, this.onUpdateCallback, this.title, this.showSubcurrencies = true, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ButtonStyleButton?> contents = _buttonLabels.map((element) {
      if(element != null) {
        return TextButton(
          onPressed: (){
            // return onPressed(context, element);
            onPressed(context, element);
          },
          child: element is String ? Text(
            element,
            style: TextStyle(
              fontSize: 22,
              color: element == "OK" ? Colors.red : null
            ),
          ) : element as Widget,
        );
      }

      return null;
    }).toList();

    return BaseSingleChoiceModal(
      title: title ?? S.current.addTransactionAmountFieldTitle,
      subtitle: showSubcurrencies ? _buildSubtitle() : Container(),
      contents: contents,
      crossAxisCount: 4,
      mainAxisCount: 5,
      actions: [
        showSubcurrencies ? IconButton(
          icon: Icon(CupertinoIcons.globe),
          onPressed: (){
            _showAvailableCurrencies(context);
          },
          color: Colors.white,
          iconSize: 30,
        ) : Container(),
      ],
    );
  }

  String? onPressed(BuildContext context, var title) {
    switch(title.runtimeType){
      case String:
        if (title == "OK"){
          Navigator.of(context).pop();
          break;
        }
        onUpdateCallback(title);
        break;
      case Icon:
        onUpdateCallback(CalculatorButton.Back);
        break;
    }
    return null;
  }

  void _showAvailableCurrencies(BuildContext context) async {
    await showMaterialModalBottomSheet(
      barrierColor: Colors.transparent,
      expand: true,
      context: context,
      builder: (context) => CurrenciesModal(),
    );
  }

  Widget _buildSubtitle(){
    return BlocBuilder<SubCurrencyBloc, SubCurrencyState>(
      builder: (context, subCurrencyState) {
        final mainCurrency = BlocProvider.of<SettingsBloc>(context).state.currency;

        if(subCurrencyState.currencies.isNotEmpty) {
          bool mainCurrencySelected = subCurrencyState.selectedSubCurrency == null;
          Color selectedColor = Color.fromRGBO(0, 0, 150, 1);
          Color baseColor = Color.fromRGBO(0, 0, 220, 1);
          List<Currency> subCurrencies = subCurrencyState.currencies;

          return Container(
            color: baseColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    child: Text(
                      getCurrencySymbol(mainCurrency),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: mainCurrencySelected ? selectedColor : null,
                    ),
                    onPressed: () {
                      BlocProvider.of<SubCurrencyBloc>(context).add(SubCurrencySelectCurrency(null));
                    },
                  )]
                + subCurrencies.map((e) => TextButton(
                    child: Text(
                      e.code,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: e == subCurrencyState.selectedSubCurrency ? selectedColor : null,
                    ),
                    onPressed: () {
                      BlocProvider.of<SubCurrencyBloc>(context).add(SubCurrencySelectCurrency(e));
                    },
                  )).toList(),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

enum CalculatorButton{Back}

final _buttonLabels = [
  "\u00F7",
  "x",
  "–",
  "+",
  "7",
  "8",
  "9",
  "=",
  "4",
  "5",
  "6",
  ".",
  "1",
  "2",
  "3",
  Icon(Icons.backspace_outlined),
  null,
  "0",
  null,
  "OK",
];