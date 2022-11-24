import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/forex/forex_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';

void updateForex(BuildContext context, DateTime dateTime){
  String mainCurrencyCode = BlocProvider.of<SettingsBloc>(context).state.currency;
  BlocProvider.of<ForexBloc>(context).add(ForexFetchData(mainCurrencyCode, dateTime));
}