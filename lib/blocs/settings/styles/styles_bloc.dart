import 'package:bloc/bloc.dart';
import 'package:radency_internship_project_2/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/styles.dart';

part 'styles_event.dart';

part 'styles_state.dart';

class StylesBloc extends Bloc<StylesEvent, StylesState> {
  SharedPreferences? prefs;

  StylesBloc() : super(StylesState(theme: 'light', themeColors: PurpleTheme())) {
    add(LoadSharedPreferences());
  }

  StylesState changeTheme(value) {
    prefs!.setString(cAppThemeKey, value);

    return StylesState(theme: value, themeColors: chooseCurrentTheme(state.themeColors.accentColor));
  }

  StylesState loadFromPreferences() {
    var theme = prefs!.getString(cAppThemeKey);
    var primaryColor = prefs!.getString(cLightThemePrimaryColorKey);
    CustomTheme currentTheme =
        primaryColor != null ? chooseCurrentTheme(primaryColor) : chooseCurrentTheme(primaryColorsArray[0]);

    return StylesState(theme: theme != null ? theme : "light", themeColors: currentTheme);
  }

  StylesState changePrimaryColor(value) {
    prefs!.setString(cLightThemePrimaryColorKey, value);

    return StylesState(theme: state.theme, themeColors: chooseCurrentTheme(value));
  }

  CustomTheme chooseCurrentTheme(color) {
    switch (color) {
      case "#5ABC7B":
        return GreenTheme();
      case '#947EB0':
        return PurpleTheme();
      case '#4896F4':
        return BlueTheme();
      case "#E25F4E":
        return RedTheme();
      default:
        return BlueTheme();
    }
  }

  @override
  Stream<StylesState> mapEventToState(StylesEvent event) async* {
    if (event is ChangeTheme) {
      yield changeTheme(event.newSettingValue);
    }

    if (event is ChangePrimaryColor) {
      yield changePrimaryColor(event.newSettingValue);
    }

    if (event is LoadSharedPreferences) {
      prefs = await SharedPreferences.getInstance();

      yield loadFromPreferences();
    }
  }
}
