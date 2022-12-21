import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/utils/kiosk.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:settings_ui/settings_ui.dart';

class AppSettingsList extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (BuildContext context, state) {
      final Stream<KioskMode> _currentMode = watchKioskMode();
      return StreamBuilder<Object>(
        stream: _currentMode,
        builder: (context, snapshot) {
          final mode = snapshot.data;

          return Container(
              child: SettingsList(
            sections: [
              SettingsSection(
                tiles: [
                  SettingsTile(
                    title: Text(S.of(context).main_currency),
                    description: Text(state.currency),
                    leading: Icon(FontAwesome5Solid.money_bill),
                    onPressed: (BuildContext context) {
                      Navigator.pushNamed(context, Routes.currencySettingPage);
                    },
                  ),
                  SettingsTile(
                    title: Text(S.of(context).language),
                    description: Text(state.language),
                    leading: Icon(FontAwesome5Solid.language),
                    onPressed: (BuildContext context) {
                      Navigator.pushNamed(context, Routes.languageSettingPage);
                    },
                  ),
                  SettingsTile(
                    title: Text(S.of(context).style),
                    leading: Icon(FontAwesome5Solid.palette),
                    onPressed: (BuildContext context) {
                      Navigator.pushNamed(context, Routes.styleSettingPage);
                    },
                  ),
                  SettingsTile(
                    title: Text(S.current.incomeCategoryTitle),
                    leading: Icon(FontAwesome5Solid.money_bill),
                    onPressed: (BuildContext context) {
                      Navigator.pushNamed(context, Routes.incomeCategoriesPage);
                    },
                  ),
                  SettingsTile(
                    title: Text(S.current.expensesCategoryTitle),
                    leading: Icon(FontAwesome5Solid.money_bill_wave),
                    onPressed: (BuildContext context) {
                      Navigator.pushNamed(context, Routes.expensesCategoriesPage);
                    },
                  ),
                  SettingsTile(
                    // title: Text(S.current.expensesCategoryTitle),
                    title: Text("Kiosk mode"),
                    description: Text(mode == KioskMode.enabled ? "on" : "off"),
                    leading: Icon(FontAwesome5Solid.lock),
                    trailing: Switch(
                      value: mode == KioskMode.enabled,
                      onChanged: (val){
                        if (val && mode == KioskMode.disabled) {
                          startKioskMode().then((value) => handleStart(context, value));
                        }
                        if (!val && mode == KioskMode.enabled) {
                          stopKioskMode().then((value) => handleStop(context, value));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ));
        }
      );
    });
  }
}
