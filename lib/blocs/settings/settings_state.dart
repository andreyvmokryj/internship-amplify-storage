part of 'settings_bloc.dart';

abstract class SettingsState {
  SettingsState({
    required this.currency,
    required this.language,
    this.onboardingCompleted
  });

  final String currency;
  final String language;
  final bool? onboardingCompleted;
}

class InitialSettingsState implements SettingsState {
  final String currency = 'UAH';
  final String language = 'ru';
  final bool onboardingCompleted = false;
}

class LoadedSettingsState implements SettingsState {
  LoadedSettingsState({required this.currency, required this.language, this.onboardingCompleted});

  final String currency;
  final String language;
  final bool? onboardingCompleted;
}
