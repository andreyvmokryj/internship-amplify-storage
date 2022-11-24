import 'package:currency_picker/src/currency_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_scaffold.dart';

import '../../../blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';

class CurrencySettingPage extends StatefulWidget {
  CurrensyPageState createState() => CurrensyPageState();
}
class CurrensyPageState extends State<CurrencySettingPage> {
  @override
  Widget build(BuildContext context) {
    var settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return DesignScaffold(
      appBar: AppBar(title: Text(S.of(context).currency)),
      body: Container(
        child: CurrencyListView(
          searchHint: S.current.searchExpensesSearchTitle,
          onSelect: (currency){
            settingsBloc.add(ChangeCurrency(newCurrencyValue: currency.code));
          },
        ),
      )
    );
  }
}
