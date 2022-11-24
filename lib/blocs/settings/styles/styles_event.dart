part of 'styles_bloc.dart';

abstract class StylesEvent {
  StylesEvent({this.settingName, this.newSettingValue});

  String? settingName;
  String? newSettingValue;
}

class LoadSharedPreferences implements StylesEvent {
  @override
  String? newSettingValue;

  @override
  String? settingName;
}

class ChangeTheme implements StylesEvent {
  ChangeTheme({this.newSettingValue});

  String? settingName = cAppThemeKey;
  String? newSettingValue;
}

class ChangePrimaryColor implements StylesEvent {
  ChangePrimaryColor({this.newSettingValue});

  String? settingName = cLightThemePrimaryColorKey;
  String? newSettingValue;
}
