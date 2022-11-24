import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';

List languages = ['ru', 'en'];

class LanguageSettingPage extends StatelessWidget{

  List<Widget> createAllLanguageRows(context, state, settingsBloc) {
    return [
        for(String language in languages)

          GestureDetector(
            child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey)
              ),
              color: state.language == language ? Theme.of(context).highlightColor : Colors.blueGrey[50]
            ), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(language),
                  state.language == language ? Icon(Icons.check) : Container()
                ],              
              )
            ),
            onTap: () {
              settingsBloc.add(ChangeLanguage(newLanguageValue: language));
              //Navigator.pop(context);
            }
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var settingsBloc =  BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, state) {

        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).language)),
          body: ListView(
            children: createAllLanguageRows(context, state, settingsBloc)
          )
        );
      }
    );
  }
}
