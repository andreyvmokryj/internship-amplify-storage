// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(email) => "Произведен вход в учетную запись: ${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accounts": MessageLookupByLibrary.simpleMessage("Счета"),
        "addTransaction":
            MessageLookupByLibrary.simpleMessage("Добавить транзакцию"),
        "addTransactionAccountFieldTitle":
            MessageLookupByLibrary.simpleMessage("Источник"),
        "addTransactionAccountFieldValidationEmpty":
            MessageLookupByLibrary.simpleMessage("Выберите источник"),
        "addTransactionAmountFieldTitle":
            MessageLookupByLibrary.simpleMessage("Сумма"),
        "addTransactionAmountFieldValidationEmpty":
            MessageLookupByLibrary.simpleMessage("Введите корректное значение"),
        "addTransactionButtonAdd":
            MessageLookupByLibrary.simpleMessage("Добавить"),
        "addTransactionButtonContinue":
            MessageLookupByLibrary.simpleMessage("Продолжить"),
        "addTransactionButtonSave":
            MessageLookupByLibrary.simpleMessage("Сохранить"),
        "addTransactionCategoryFieldTitle":
            MessageLookupByLibrary.simpleMessage("Категория"),
        "addTransactionCategoryFieldValidationEmpty":
            MessageLookupByLibrary.simpleMessage("Выберите категорию"),
        "addTransactionDateFieldTitle":
            MessageLookupByLibrary.simpleMessage("Дата"),
        "addTransactionFeesFieldTitle":
            MessageLookupByLibrary.simpleMessage("Комиссия"),
        "addTransactionFromFieldTitle":
            MessageLookupByLibrary.simpleMessage("Источник"),
        "addTransactionFromFieldValidationEmpty":
            MessageLookupByLibrary.simpleMessage("Укажите источник"),
        "addTransactionLocationFieldHint": MessageLookupByLibrary.simpleMessage(
            "Нажмите для выбора местоположения"),
        "addTransactionLocationFieldTitle":
            MessageLookupByLibrary.simpleMessage("Местоположение"),
        "addTransactionLocationMenuCancel":
            MessageLookupByLibrary.simpleMessage("Отменить выбор"),
        "addTransactionLocationMenuCurrent":
            MessageLookupByLibrary.simpleMessage(
                "Указать текущее местоположение"),
        "addTransactionLocationMenuFromMap":
            MessageLookupByLibrary.simpleMessage("Выбрать на карте"),
        "addTransactionNoteFieldTitle":
            MessageLookupByLibrary.simpleMessage("Примечение"),
        "addTransactionSharedFieldTitle":
            MessageLookupByLibrary.simpleMessage("Совмесно с"),
        "addTransactionSnackBarLocationSelectCancelled":
            MessageLookupByLibrary.simpleMessage(
                "Выбор местоположения отменён"),
        "addTransactionSnackBarSuccessMessage":
            MessageLookupByLibrary.simpleMessage("Сохранено"),
        "addTransactionToFieldTitle":
            MessageLookupByLibrary.simpleMessage("Назначение"),
        "addTransactionToFieldValidationEmpty":
            MessageLookupByLibrary.simpleMessage("Укажите назначение"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Имя приложения"),
        "aprilShort": MessageLookupByLibrary.simpleMessage("Апр."),
        "augustShort": MessageLookupByLibrary.simpleMessage("Авг."),
        "authenticationBiometricsErrorLockedOut":
            MessageLookupByLibrary.simpleMessage("Превышен лимит попыток"),
        "authenticationBiometricsErrorNotAvailable":
            MessageLookupByLibrary.simpleMessage(
                "Ваше устройство не поддерживает функции считывания отпечатка пальца или лица"),
        "authenticationBiometricsErrorNotEnrolled":
            MessageLookupByLibrary.simpleMessage(
                "Ваше устройство не содержит сохраненных отпечатков пальцев или лиц"),
        "authenticationBiometricsErrorUnknownError":
            MessageLookupByLibrary.simpleMessage(
                "Возникла непредвиденная ошибка считывания отпечатка пальца или лица"),
        "authenticationBiometricsFailure":
            MessageLookupByLibrary.simpleMessage("Не удалось идентифицировать"),
        "authenticationBiometricsLoginButton":
            MessageLookupByLibrary.simpleMessage("Войти используя биометрию"),
        "authenticationBiometricsPairCheckbox":
            MessageLookupByLibrary.simpleMessage(
                "Использовать биометрию для входа"),
        "authenticationBiometricsReasonRead":
            MessageLookupByLibrary.simpleMessage(
                "Авторизируйтесь для входа в учетную запись"),
        "authenticationBiometricsReasonSave":
            MessageLookupByLibrary.simpleMessage(
                "Авторизируйтесь для сохранения учетных данных"),
        "authenticationBiometricsSuccessful": m0,
        "camera": MessageLookupByLibrary.simpleMessage("Сделать фото чека"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "categoriesDefaultOther":
            MessageLookupByLibrary.simpleMessage("Другое"),
        "categoryName": MessageLookupByLibrary.simpleMessage("Имя категории"),
        "confirmButton": MessageLookupByLibrary.simpleMessage("ПОДТВЕРДИТЬ"),
        "createNewAccount":
            MessageLookupByLibrary.simpleMessage("Создать новый!"),
        "currency": MessageLookupByLibrary.simpleMessage("Валюта"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Тёмная тема"),
        "decemberShort": MessageLookupByLibrary.simpleMessage("Дек."),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "emailVerificationNotice": MessageLookupByLibrary.simpleMessage(
            "Для активации учетной записи перейдите по ссылке, отправленной на указанный вами адрес электронной почты. Если вы не получили письмо, проверьте папку Спам или запросите новое письмо."),
        "emailVerificationResendButton":
            MessageLookupByLibrary.simpleMessage("Отправить"),
        "emailVerificationTitle": MessageLookupByLibrary.simpleMessage(
            "Подтверждение электронной почты"),
        "enterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Введите номер телефона"),
        "exampleTitle":
            MessageLookupByLibrary.simpleMessage("РУ Пример Заголовка"),
        "expense": MessageLookupByLibrary.simpleMessage("Расходы"),
        "expenses": MessageLookupByLibrary.simpleMessage("Расходы"),
        "expensesCategoryTitle":
            MessageLookupByLibrary.simpleMessage("Категории расходов"),
        "export_csv": MessageLookupByLibrary.simpleMessage("Экспорт csv"),
        "februaryShort": MessageLookupByLibrary.simpleMessage("Фев."),
        "form":
            MessageLookupByLibrary.simpleMessage("Заполнить форму транзакции"),
        "fridayShort": MessageLookupByLibrary.simpleMessage("Пт"),
        "gallery": MessageLookupByLibrary.simpleMessage("Чек из галереи"),
        "home": MessageLookupByLibrary.simpleMessage("Главная"),
        "importCsv": MessageLookupByLibrary.simpleMessage("Импорт csv"),
        "import_csv": MessageLookupByLibrary.simpleMessage("Импорт из csv"),
        "income": MessageLookupByLibrary.simpleMessage("Доходы"),
        "incomeCategoryTitle":
            MessageLookupByLibrary.simpleMessage("Категории доходов"),
        "incorrectPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Укажите номер в международном формате"),
        "januaryShort": MessageLookupByLibrary.simpleMessage("Янв."),
        "julyShort": MessageLookupByLibrary.simpleMessage("Июл."),
        "juneShort": MessageLookupByLibrary.simpleMessage("Июн."),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Светлая тема"),
        "loginButton": MessageLookupByLibrary.simpleMessage("ВОЙТИ"),
        "loginCreateAccountButton":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "loginEmailLabelText":
            MessageLookupByLibrary.simpleMessage("Адрес электронной почты"),
        "loginEmailValidatorEmpty": MessageLookupByLibrary.simpleMessage(
            "Укажите адрес электронной почты"),
        "loginEmailValidatorIncorrect": MessageLookupByLibrary.simpleMessage(
            "Укажите правильный адрес электронной почты"),
        "loginForgotPasswordButton":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "loginNoAccountNotice":
            MessageLookupByLibrary.simpleMessage("Нет учетной записи?"),
        "loginNoticeText": MessageLookupByLibrary.simpleMessage(
            "Авторизируйтесь, чтобы продолжить"),
        "loginPasswordLabelText":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "loginPasswordValidatorEmpty":
            MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "loginSubmitButton": MessageLookupByLibrary.simpleMessage("ВОЙТИ"),
        "loginToolbarTitle": MessageLookupByLibrary.simpleMessage("Вход"),
        "loginWelcomeText":
            MessageLookupByLibrary.simpleMessage("Money Manager"),
        "main_currency":
            MessageLookupByLibrary.simpleMessage("Основная валюта"),
        "marchShort": MessageLookupByLibrary.simpleMessage("Мар."),
        "mayShort": MessageLookupByLibrary.simpleMessage("Май"),
        "mondayShort": MessageLookupByLibrary.simpleMessage("Пн"),
        "newCategory": MessageLookupByLibrary.simpleMessage("Новая категория"),
        "noAccount": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
        "noCategoriesExpensesDetailsMessage":
            MessageLookupByLibrary.simpleMessage(
                "В данном диапазоне нет трат!"),
        "noDataForCurrentDateRangeMessage": MessageLookupByLibrary.simpleMessage(
            "Отсутствуют данные для данного диапазона! Смените дату или добавьте новую транзакцию."),
        "novemberShort": MessageLookupByLibrary.simpleMessage("Ноя."),
        "octoberShort": MessageLookupByLibrary.simpleMessage("Окт."),
        "otpIncorrectPassword": MessageLookupByLibrary.simpleMessage(
            "Неправильный одноразовый пароль!"),
        "otpPassSendToNumber": MessageLookupByLibrary.simpleMessage(
            "Одноразовый пароль был отправлен на номер:"),
        "passcode": MessageLookupByLibrary.simpleMessage("Пароль"),
        "refreshButtonText": MessageLookupByLibrary.simpleMessage("Обновить"),
        "saturdayShort": MessageLookupByLibrary.simpleMessage("Сб"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "searchExpensesAllCheckbox":
            MessageLookupByLibrary.simpleMessage("Все"),
        "searchExpensesSearchTitle":
            MessageLookupByLibrary.simpleMessage("Поиск"),
        "septemberShort": MessageLookupByLibrary.simpleMessage("Сен."),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "signInSuccessful":
            MessageLookupByLibrary.simpleMessage("Вход совершён успешно!"),
        "signUpApplyCredentialsButton":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "signUpCreateAccountHeader":
            MessageLookupByLibrary.simpleMessage("Создайте учетную запись"),
        "signUpEmailLabelText":
            MessageLookupByLibrary.simpleMessage("Электронная почта"),
        "signUpEmailValidatorEmpty": MessageLookupByLibrary.simpleMessage(
            "Укажите адрес электронной почты"),
        "signUpEmailValidatorIncorrect": MessageLookupByLibrary.simpleMessage(
            "Укажите правильный адрес электронной почты"),
        "signUpOTPContinueButton":
            MessageLookupByLibrary.simpleMessage("Продолжить"),
        "signUpOTPNotice": MessageLookupByLibrary.simpleMessage(
            "На указанный номер будет отправлен одноразовый пароль"),
        "signUpOTPSentNotice": MessageLookupByLibrary.simpleMessage(
            "Введите одноразовый пароль, который был отправлен на номер:"),
        "signUpOTPValidatorIncorrect":
            MessageLookupByLibrary.simpleMessage("Введите корректный пароль"),
        "signUpPageTitle": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "signUpPasswordConfirmationLabelText":
            MessageLookupByLibrary.simpleMessage("Подтверждение пароля"),
        "signUpPasswordConfirmationValidatorNotMatch":
            MessageLookupByLibrary.simpleMessage("Пароли не совпадают"),
        "signUpPasswordLabelText":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "signUpPasswordValidatorEmpty":
            MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "signUpPhoneNumberLabelText": MessageLookupByLibrary.simpleMessage(
            "Номер телефона в международном формате"),
        "signUpPhoneNumberValidatorEmpty":
            MessageLookupByLibrary.simpleMessage("Укажите номер телефона"),
        "signUpPhoneNumberValidatorIncorrect":
            MessageLookupByLibrary.simpleMessage(
                "Укажите корректный номер телефона"),
        "signUpUsernameLabelText":
            MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "signUpUsernameValidatorEmpty":
            MessageLookupByLibrary.simpleMessage("Укажите имя пользователя"),
        "signUpWrongNumberButton":
            MessageLookupByLibrary.simpleMessage("Неправильный номер?"),
        "stats": MessageLookupByLibrary.simpleMessage("Статистика"),
        "statsBudgetMonthlyRemainingTitle":
            MessageLookupByLibrary.simpleMessage("Остаток (этот месяц)"),
        "statsBudgetMonthlyTotalTitle":
            MessageLookupByLibrary.simpleMessage("Этот месяц"),
        "statsBudgetSetupFieldValidatorIncorrect":
            MessageLookupByLibrary.simpleMessage("Введите правильное значение"),
        "statsBudgetSetupSaveButton":
            MessageLookupByLibrary.simpleMessage("Сохранить"),
        "statsBudgetSetupSaveDescription":
            MessageLookupByLibrary.simpleMessage("Введите желаемый бюджет"),
        "statsBudgetViewBudgetSettingsTitle":
            MessageLookupByLibrary.simpleMessage("Настройки бюджета"),
        "statsBudgetViewRemainingMonthlyTitle":
            MessageLookupByLibrary.simpleMessage("Остаток (месяц)"),
        "statsViewButtonBudget": MessageLookupByLibrary.simpleMessage("Бюджет"),
        "statsViewButtonNote": MessageLookupByLibrary.simpleMessage("Заметки"),
        "statsViewButtonStats": MessageLookupByLibrary.simpleMessage("Стат."),
        "statsViewChartTab": MessageLookupByLibrary.simpleMessage("График"),
        "statsViewMapTab": MessageLookupByLibrary.simpleMessage("Карта"),
        "style": MessageLookupByLibrary.simpleMessage("Стили"),
        "stylePageTitle": MessageLookupByLibrary.simpleMessage("Стиль"),
        "subCurrencySettingTitle":
            MessageLookupByLibrary.simpleMessage("Выбор доп. валюты"),
        "sundayShort": MessageLookupByLibrary.simpleMessage("Вс"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Системная тема"),
        "thursdayShort": MessageLookupByLibrary.simpleMessage("Чт"),
        "total": MessageLookupByLibrary.simpleMessage("Итого"),
        "transaction": MessageLookupByLibrary.simpleMessage("Транзакция"),
        "transactionsTabButtonExpensesCashAccounts":
            MessageLookupByLibrary.simpleMessage("Расходы (Наличные, счета)"),
        "transactionsTabButtonExpensesCreditCards":
            MessageLookupByLibrary.simpleMessage("Расходы (Кредитные карты)"),
        "transactionsTabButtonExportToCSV":
            MessageLookupByLibrary.simpleMessage("Экспортировать данные в CSV"),
        "transactionsTabTitleAccount":
            MessageLookupByLibrary.simpleMessage("Счёт"),
        "transactionsTabTitleCalendar":
            MessageLookupByLibrary.simpleMessage("Календарь"),
        "transactionsTabTitleDaily":
            MessageLookupByLibrary.simpleMessage("По дням"),
        "transactionsTabTitleMonthly":
            MessageLookupByLibrary.simpleMessage("По месяцам"),
        "transactionsTabTitleSummary":
            MessageLookupByLibrary.simpleMessage("Сводка"),
        "transactionsTabTitleWeekly":
            MessageLookupByLibrary.simpleMessage("По неделям"),
        "transfer": MessageLookupByLibrary.simpleMessage("Перевод"),
        "tuesdayShort": MessageLookupByLibrary.simpleMessage("Вт"),
        "wednesdayShort": MessageLookupByLibrary.simpleMessage("Ср"),
        "wrongNumber": MessageLookupByLibrary.simpleMessage("Не ваш номер?"),
        "yourPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Ваш номер телефона")
      };
}
