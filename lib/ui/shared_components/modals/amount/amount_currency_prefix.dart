import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/sub_currency/sub_currency_bloc.dart';
import 'package:radency_internship_project_2/utils/strings.dart';

class AmountCurrencyPrefix extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCurrencyBloc, SubCurrencyState>(
      builder: (context, state){
        String mainCurrency = BlocProvider.of<SettingsBloc>(context).state.currency;

        return Text(state.selectedSubCurrency?.symbol ?? getCurrencySymbol(mainCurrency));
      }
    );
  }

}