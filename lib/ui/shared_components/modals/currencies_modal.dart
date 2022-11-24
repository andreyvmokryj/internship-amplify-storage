import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/forex/forex_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/sub_currency/sub_currency_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class CurrenciesModal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.subCurrencySettingTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){}
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                searchHint: S.current.searchExpensesSearchTitle,
                onSelect: (Currency currency) {
                  print('Select currency: ${currency.name}');
                  BlocProvider.of<SubCurrencyBloc>(context).add(SubCurrencyAddCurrency(currency));
                },
              );
            }
          )
        ],
      ),
      body: BlocConsumer<SubCurrencyBloc, SubCurrencyState>(
        listener: (context, subCurrencyState){
          if(subCurrencyState is SubCurrencyLoaded){
            refreshForex(context);
          }
        },
        builder: (context, subCurrencyState) {
          return BlocBuilder<ForexBloc, ForexState>(
            builder: (context, forexState){
              if(subCurrencyState is SubCurrencyLoading || forexState is ForexStateLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(subCurrencyState is SubCurrencyLoaded && forexState.forex != {}) {
                String mainCurrencyCode = BlocProvider.of<SettingsBloc>(context).state.currency;
                List<Currency> currencies = subCurrencyState.currencies;

                return SingleChildScrollView(
                  child: Column(
                    children: currencies.expand((element) {
                      String exchangeRate = (forexState.forex![element.code] ?? 0).toStringAsFixed(7);

                      return [
                        ListTile(
                          title: Text(
                            "${element.code} 1.00 = $mainCurrencyCode $exchangeRate",
                            style: currencyModalTitleStyle,
                          ),
                          subtitle: Text(
                            "${element.code} –  ${element.name} (${element.symbol})",
                            style: currencyModalSubtitleStyle,
                          ),
                          onTap: () {
                            BlocProvider.of<SubCurrencyBloc>(context).add(SubCurrencySelectCurrency(element));
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(
                          thickness: 1.1,
                        ),
                      ];
                    }).toList(),
                  ),
                );
              }

              return Container();
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.refresh),
        onPressed: () {
          refreshForex(context);
        },
      ),
    );
  }

  void refreshForex(BuildContext context) async {
    String baseCode = BlocProvider.of<SettingsBloc>(context).state.currency;

    BlocProvider.of<ForexBloc>(context).add(ForexFetchData(baseCode));
  }
}