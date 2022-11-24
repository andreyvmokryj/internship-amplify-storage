part of 'settings_bloc.dart';

abstract class SettingsEvent {
  SettingsEvent();
}

class InitialSettingsEvent implements SettingsEvent {
  InitialSettingsEvent();
}

class ChangeCurrency implements SettingsEvent {
  ChangeCurrency({required this.newCurrencyValue});

  String newCurrencyValue;
}

class ChangeLanguage implements SettingsEvent {
  ChangeLanguage({required this.newLanguageValue});

  String newLanguageValue;
}
