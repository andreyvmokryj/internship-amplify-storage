import 'package:bloc/bloc.dart';
import 'package:radency_internship_project_2/repositories/settings_repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc(this.settingsRepository)
      : super(InitialSettingsState());

  SettingsState changeCurrency(value) {
    return LoadedSettingsState(currency: value, language: state.language);
  }

  SettingsState changeLanguage(value) {
    return LoadedSettingsState(language: value, currency: state.currency);
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is InitialSettingsEvent) {
      SettingsState loadedSettings = await settingsRepository.get();
      yield loadedSettings;
    } else if (event is ChangeCurrency) {
      yield changeCurrency(event.newCurrencyValue);
      await settingsRepository.set('currency', event.newCurrencyValue);
    } else if (event is ChangeLanguage) {
      yield changeLanguage(event.newLanguageValue);
      await settingsRepository.set('language', event.newLanguageValue);
    }
  }
}
