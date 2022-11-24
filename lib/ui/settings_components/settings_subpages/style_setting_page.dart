import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/styles/styles_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';

import '../../../utils/styles.dart';

class StyleSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StylesBloc, StylesState>(builder: (context, state) {
      var colorsArray = List<Widget>.empty(growable: true);

      primaryColorsArray.forEach((element) {
        colorsArray.add(buildRoundColorButton(context, element, state.themeColors.accentColor));
      });

      return Scaffold(
          appBar: AppBar(title: Text(S.current.stylePageTitle)),
          body: Column(
            children: <Widget>[
              Divider(),
              buildThemeGroupItem(
                  context, S.current.lightTheme, const IconData(60130, fontFamily: 'MaterialIcons'), "light", state
                  .theme),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: colorsArray,
                ),
              ),
              Divider(),
              buildThemeGroupItem(
                  context, S.current.darkTheme, const IconData(59566, fontFamily: 'MaterialIcons'), "dark", state
                  .theme),
              Divider(),
              buildThemeGroupItem(
                  context, S.current.systemTheme, const IconData(59987, fontFamily: 'MaterialIcons'), "system", state
                  .theme),
              Divider(),
            ],
          ));
    });
  }

  Widget buildRoundColorButton(BuildContext context, String buttonColor, String activeColor) {
    Color accentColor = Theme.of(context).colorScheme.secondary;

    return Expanded(
        child: GestureDetector(
            onTap: () {
              context.read<StylesBloc>().add(ChangePrimaryColor(newSettingValue: buttonColor));
            },
            child: Container(
              width: 30,
              height: 30,
              child: Center(
                child: buttonColor == activeColor
                    ? Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: HexColor(buttonColor)))
                    : null,
              ),
              decoration: BoxDecoration(
                  border: buttonColor == activeColor ? Border.all(color: accentColor, width: 2) : null,
                  shape: BoxShape.circle,
                  color: HexColor(buttonColor)),
            )));
  }

  Widget buildThemeGroupItem(
      BuildContext context, String itemName, IconData iconData, String value, String groupValue) {
    return GestureDetector(
        onTap: () {
          context.read<StylesBloc>().add(ChangeTheme(newSettingValue: value));
        },
        child: ListTile(
          title: Row(
            children: [
              Icon(iconData),
              Expanded(
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text(itemName)),
              ),
            ],
          ),
          leading: Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (value) {
              context.read<StylesBloc>().add(ChangeTheme(newSettingValue: value ?? ""));
            },
          ),
        ));
  }
}
