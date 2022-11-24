// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Example EN Title`
  String get exampleTitle {
    return Intl.message(
      'Example EN Title',
      name: 'exampleTitle',
      desc: '',
      args: [],
    );
  }

  /// `App Title`
  String get appTitle {
    return Intl.message(
      'App Title',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your phone number`
  String get yourPhoneNumber {
    return Intl.message(
      'Your phone number',
      name: 'yourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginToolbarTitle {
    return Intl.message(
      'Login',
      name: 'loginToolbarTitle',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get loginButton {
    return Intl.message(
      'LOGIN',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create a new!`
  String get createNewAccount {
    return Intl.message(
      'Create a new!',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter the number in international format`
  String get incorrectPhoneNumber {
    return Intl.message(
      'Enter the number in international format',
      name: 'incorrectPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `One-time password was sent to the number: `
  String get otpPassSendToNumber {
    return Intl.message(
      'One-time password was sent to the number: ',
      name: 'otpPassSendToNumber',
      desc: '',
      args: [],
    );
  }

  /// `Wrong number?`
  String get wrongNumber {
    return Intl.message(
      'Wrong number?',
      name: 'wrongNumber',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRM`
  String get confirmButton {
    return Intl.message(
      'CONFIRM',
      name: 'confirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect otp password!`
  String get otpIncorrectPassword {
    return Intl.message(
      'Incorrect otp password!',
      name: 'otpIncorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In successful!`
  String get signInSuccessful {
    return Intl.message(
      'Sign In successful!',
      name: 'signInSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get stats {
    return Intl.message(
      'Stats',
      name: 'stats',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Import from csv`
  String get import_csv {
    return Intl.message(
      'Import from csv',
      name: 'import_csv',
      desc: '',
      args: [],
    );
  }

  /// `Export as csv`
  String get export_csv {
    return Intl.message(
      'Export as csv',
      name: 'export_csv',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Main currency`
  String get main_currency {
    return Intl.message(
      'Main currency',
      name: 'main_currency',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get style {
    return Intl.message(
      'Style',
      name: 'style',
      desc: '',
      args: [],
    );
  }

  /// `Passcode`
  String get passcode {
    return Intl.message(
      'Passcode',
      name: 'passcode',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add transaction manualy`
  String get form {
    return Intl.message(
      'Add transaction manualy',
      name: 'form',
      desc: '',
      args: [],
    );
  }

  /// `Bill from gallery`
  String get gallery {
    return Intl.message(
      'Bill from gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Bill from camera`
  String get camera {
    return Intl.message(
      'Bill from camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Import csv`
  String get importCsv {
    return Intl.message(
      'Import csv',
      name: 'importCsv',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get mondayShort {
    return Intl.message(
      'Mon',
      name: 'mondayShort',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tuesdayShort {
    return Intl.message(
      'Tue',
      name: 'tuesdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wednesdayShort {
    return Intl.message(
      'Wed',
      name: 'wednesdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thursdayShort {
    return Intl.message(
      'Thu',
      name: 'thursdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get fridayShort {
    return Intl.message(
      'Fri',
      name: 'fridayShort',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get saturdayShort {
    return Intl.message(
      'Sat',
      name: 'saturdayShort',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sundayShort {
    return Intl.message(
      'Sun',
      name: 'sundayShort',
      desc: '',
      args: [],
    );
  }

  /// `Jan.`
  String get januaryShort {
    return Intl.message(
      'Jan.',
      name: 'januaryShort',
      desc: '',
      args: [],
    );
  }

  /// `Feb.`
  String get februaryShort {
    return Intl.message(
      'Feb.',
      name: 'februaryShort',
      desc: '',
      args: [],
    );
  }

  /// `Mar.`
  String get marchShort {
    return Intl.message(
      'Mar.',
      name: 'marchShort',
      desc: '',
      args: [],
    );
  }

  /// `Apr.`
  String get aprilShort {
    return Intl.message(
      'Apr.',
      name: 'aprilShort',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get mayShort {
    return Intl.message(
      'May',
      name: 'mayShort',
      desc: '',
      args: [],
    );
  }

  /// `Jun.`
  String get juneShort {
    return Intl.message(
      'Jun.',
      name: 'juneShort',
      desc: '',
      args: [],
    );
  }

  /// `Jul.`
  String get julyShort {
    return Intl.message(
      'Jul.',
      name: 'julyShort',
      desc: '',
      args: [],
    );
  }

  /// `Aug.`
  String get augustShort {
    return Intl.message(
      'Aug.',
      name: 'augustShort',
      desc: '',
      args: [],
    );
  }

  /// `Sep.`
  String get septemberShort {
    return Intl.message(
      'Sep.',
      name: 'septemberShort',
      desc: '',
      args: [],
    );
  }

  /// `Oct.`
  String get octoberShort {
    return Intl.message(
      'Oct.',
      name: 'octoberShort',
      desc: '',
      args: [],
    );
  }

  /// `Nov.`
  String get novemberShort {
    return Intl.message(
      'Nov.',
      name: 'novemberShort',
      desc: '',
      args: [],
    );
  }

  /// `Dec.`
  String get decemberShort {
    return Intl.message(
      'Dec.',
      name: 'decemberShort',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Add transaction`
  String get addTransaction {
    return Intl.message(
      'Add transaction',
      name: 'addTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get transactionsTabTitleDaily {
    return Intl.message(
      'Daily',
      name: 'transactionsTabTitleDaily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get transactionsTabTitleWeekly {
    return Intl.message(
      'Weekly',
      name: 'transactionsTabTitleWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get transactionsTabTitleMonthly {
    return Intl.message(
      'Monthly',
      name: 'transactionsTabTitleMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get transactionsTabTitleSummary {
    return Intl.message(
      'Summary',
      name: 'transactionsTabTitleSummary',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get transactionsTabTitleCalendar {
    return Intl.message(
      'Calendar',
      name: 'transactionsTabTitleCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get transactionsTabTitleAccount {
    return Intl.message(
      'Account',
      name: 'transactionsTabTitleAccount',
      desc: '',
      args: [],
    );
  }

  /// `Export data to CSV`
  String get transactionsTabButtonExportToCSV {
    return Intl.message(
      'Export data to CSV',
      name: 'transactionsTabButtonExportToCSV',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expenses {
    return Intl.message(
      'Expenses',
      name: 'expenses',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Expenses (Cash, Accounts)`
  String get transactionsTabButtonExpensesCashAccounts {
    return Intl.message(
      'Expenses (Cash, Accounts)',
      name: 'transactionsTabButtonExpensesCashAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Expenses (Credit Cards)`
  String get transactionsTabButtonExpensesCreditCards {
    return Intl.message(
      'Expenses (Credit Cards)',
      name: 'transactionsTabButtonExpensesCreditCards',
      desc: '',
      args: [],
    );
  }

  /// `There is no data available for this period! Switch date range or add new transaction`
  String get noDataForCurrentDateRangeMessage {
    return Intl.message(
      'There is no data available for this period! Switch date range or add new transaction',
      name: 'noDataForCurrentDateRangeMessage',
      desc: '',
      args: [],
    );
  }

  /// `There are no expenses for current period!`
  String get noCategoriesExpensesDetailsMessage {
    return Intl.message(
      'There are no expenses for current period!',
      name: 'noCategoriesExpensesDetailsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refreshButtonText {
    return Intl.message(
      'Refresh',
      name: 'refreshButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message(
      'Expense',
      name: 'expense',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get stylePageTitle {
    return Intl.message(
      'Style',
      name: 'stylePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get systemTheme {
    return Intl.message(
      'System Theme',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Money Manager`
  String get loginWelcomeText {
    return Intl.message(
      'Money Manager',
      name: 'loginWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get loginNoticeText {
    return Intl.message(
      'Sign in to continue',
      name: 'loginNoticeText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmailLabelText {
    return Intl.message(
      'Email',
      name: 'loginEmailLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPasswordLabelText {
    return Intl.message(
      'Password',
      name: 'loginPasswordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Enter e-mail`
  String get loginEmailValidatorEmpty {
    return Intl.message(
      'Enter e-mail',
      name: 'loginEmailValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct email`
  String get loginEmailValidatorIncorrect {
    return Intl.message(
      'Enter correct email',
      name: 'loginEmailValidatorIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get loginPasswordValidatorEmpty {
    return Intl.message(
      'Enter password',
      name: 'loginPasswordValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get loginForgotPasswordButton {
    return Intl.message(
      'Forgot password?',
      name: 'loginForgotPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get loginSubmitButton {
    return Intl.message(
      'LOGIN',
      name: 'loginSubmitButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get loginNoAccountNotice {
    return Intl.message(
      'Don\'t have account?',
      name: 'loginNoAccountNotice',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get loginCreateAccountButton {
    return Intl.message(
      'Create a new account',
      name: 'loginCreateAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpPageTitle {
    return Intl.message(
      'Sign Up',
      name: 'signUpPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get signUpCreateAccountHeader {
    return Intl.message(
      'Create account',
      name: 'signUpCreateAccountHeader',
      desc: '',
      args: [],
    );
  }

  /// `A one-time password will be sent to your phone number`
  String get signUpOTPNotice {
    return Intl.message(
      'A one-time password will be sent to your phone number',
      name: 'signUpOTPNotice',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpApplyCredentialsButton {
    return Intl.message(
      'Sign up',
      name: 'signUpApplyCredentialsButton',
      desc: '',
      args: [],
    );
  }

  /// `Phone number in international format`
  String get signUpPhoneNumberLabelText {
    return Intl.message(
      'Phone number in international format',
      name: 'signUpPhoneNumberLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get signUpPhoneNumberValidatorEmpty {
    return Intl.message(
      'Enter phone number',
      name: 'signUpPhoneNumberValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct phone number`
  String get signUpPhoneNumberValidatorIncorrect {
    return Intl.message(
      'Enter correct phone number',
      name: 'signUpPhoneNumberValidatorIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get signUpEmailLabelText {
    return Intl.message(
      'E-mail',
      name: 'signUpEmailLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Enter e-mail`
  String get signUpEmailValidatorEmpty {
    return Intl.message(
      'Enter e-mail',
      name: 'signUpEmailValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct email`
  String get signUpEmailValidatorIncorrect {
    return Intl.message(
      'Enter correct email',
      name: 'signUpEmailValidatorIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get signUpUsernameLabelText {
    return Intl.message(
      'Username',
      name: 'signUpUsernameLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get signUpUsernameValidatorEmpty {
    return Intl.message(
      'Enter username',
      name: 'signUpUsernameValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter a one-time password that was sent to number:`
  String get signUpOTPSentNotice {
    return Intl.message(
      'Please, enter a one-time password that was sent to number:',
      name: 'signUpOTPSentNotice',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter a correct one-time password`
  String get signUpOTPValidatorIncorrect {
    return Intl.message(
      'Please, enter a correct one-time password',
      name: 'signUpOTPValidatorIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Wrong number?`
  String get signUpWrongNumberButton {
    return Intl.message(
      'Wrong number?',
      name: 'signUpWrongNumberButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get signUpOTPContinueButton {
    return Intl.message(
      'Continue',
      name: 'signUpOTPContinueButton',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signUpPasswordLabelText {
    return Intl.message(
      'Password',
      name: 'signUpPasswordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get signUpPasswordConfirmationLabelText {
    return Intl.message(
      'Confirm password',
      name: 'signUpPasswordConfirmationLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get signUpPasswordValidatorEmpty {
    return Intl.message(
      'Enter password',
      name: 'signUpPasswordValidatorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get signUpPasswordConfirmationValidatorNotMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'signUpPasswordConfirmationValidatorNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't apply fingerprint/face`
  String get authenticationBiometricsFailure {
    return Intl.message(
      'Couldn\'t apply fingerprint/face',
      name: 'authenticationBiometricsFailure',
      desc: '',
      args: [],
    );
  }

  /// `Logged in with email: {email}`
  String authenticationBiometricsSuccessful(Object email) {
    return Intl.message(
      'Logged in with email: $email',
      name: 'authenticationBiometricsSuccessful',
      desc: '',
      args: [email],
    );
  }

  /// `Please authenticate in order to save credentials`
  String get authenticationBiometricsReasonSave {
    return Intl.message(
      'Please authenticate in order to save credentials',
      name: 'authenticationBiometricsReasonSave',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate in order to log in`
  String get authenticationBiometricsReasonRead {
    return Intl.message(
      'Please authenticate in order to log in',
      name: 'authenticationBiometricsReasonRead',
      desc: '',
      args: [],
    );
  }

  /// `Use biometrics`
  String get authenticationBiometricsPairCheckbox {
    return Intl.message(
      'Use biometrics',
      name: 'authenticationBiometricsPairCheckbox',
      desc: '',
      args: [],
    );
  }

  /// `Login using biometrics`
  String get authenticationBiometricsLoginButton {
    return Intl.message(
      'Login using biometrics',
      name: 'authenticationBiometricsLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Your device does not support biometric authentication`
  String get authenticationBiometricsErrorNotAvailable {
    return Intl.message(
      'Your device does not support biometric authentication',
      name: 'authenticationBiometricsErrorNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Your device does not have any registered fingerprints or faces`
  String get authenticationBiometricsErrorNotEnrolled {
    return Intl.message(
      'Your device does not have any registered fingerprints or faces',
      name: 'authenticationBiometricsErrorNotEnrolled',
      desc: '',
      args: [],
    );
  }

  /// `Too many unsuccessful attempts`
  String get authenticationBiometricsErrorLockedOut {
    return Intl.message(
      'Too many unsuccessful attempts',
      name: 'authenticationBiometricsErrorLockedOut',
      desc: '',
      args: [],
    );
  }

  /// `Unknown biometric authentication error`
  String get authenticationBiometricsErrorUnknownError {
    return Intl.message(
      'Unknown biometric authentication error',
      name: 'authenticationBiometricsErrorUnknownError',
      desc: '',
      args: [],
    );
  }

  /// `Email verification`
  String get emailVerificationTitle {
    return Intl.message(
      'Email verification',
      name: 'emailVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `We sent a confirmation email to the email address you provided during registration. If you did not receive it, check your Spam or request a new confirmation email.`
  String get emailVerificationNotice {
    return Intl.message(
      'We sent a confirmation email to the email address you provided during registration. If you did not receive it, check your Spam or request a new confirmation email.',
      name: 'emailVerificationNotice',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get emailVerificationResendButton {
    return Intl.message(
      'Resend',
      name: 'emailVerificationResendButton',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addTransactionButtonAdd {
    return Intl.message(
      'Add',
      name: 'addTransactionButtonAdd',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get addTransactionButtonSave {
    return Intl.message(
      'Save',
      name: 'addTransactionButtonSave',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get addTransactionButtonContinue {
    return Intl.message(
      'Continue',
      name: 'addTransactionButtonContinue',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get addTransactionDateFieldTitle {
    return Intl.message(
      'Date',
      name: 'addTransactionDateFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get addTransactionAccountFieldTitle {
    return Intl.message(
      'Account',
      name: 'addTransactionAccountFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get addTransactionCategoryFieldTitle {
    return Intl.message(
      'Category',
      name: 'addTransactionCategoryFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get addTransactionAmountFieldTitle {
    return Intl.message(
      'Amount',
      name: 'addTransactionAmountFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get addTransactionNoteFieldTitle {
    return Intl.message(
      'Note',
      name: 'addTransactionNoteFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get addTransactionFromFieldTitle {
    return Intl.message(
      'From',
      name: 'addTransactionFromFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get addTransactionToFieldTitle {
    return Intl.message(
      'To',
      name: 'addTransactionToFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get addTransactionFeesFieldTitle {
    return Intl.message(
      'Fees',
      name: 'addTransactionFeesFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shared`
  String get addTransactionSharedFieldTitle {
    return Intl.message(
      'Shared',
      name: 'addTransactionSharedFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get addTransactionLocationFieldTitle {
    return Intl.message(
      'Location',
      name: 'addTransactionLocationFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select category`
  String get addTransactionCategoryFieldValidationEmpty {
    return Intl.message(
      'Select category',
      name: 'addTransactionCategoryFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Select account type`
  String get addTransactionAccountFieldValidationEmpty {
    return Intl.message(
      'Select account type',
      name: 'addTransactionAccountFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct amount`
  String get addTransactionAmountFieldValidationEmpty {
    return Intl.message(
      'Enter correct amount',
      name: 'addTransactionAmountFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter source`
  String get addTransactionFromFieldValidationEmpty {
    return Intl.message(
      'Enter source',
      name: 'addTransactionFromFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter destination`
  String get addTransactionToFieldValidationEmpty {
    return Intl.message(
      'Enter destination',
      name: 'addTransactionToFieldValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get incomeCategoryTitle {
    return Intl.message(
      'Income',
      name: 'incomeCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expensesCategoryTitle {
    return Intl.message(
      'Expenses',
      name: 'expensesCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `New Category`
  String get newCategory {
    return Intl.message(
      'New Category',
      name: 'newCategory',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select location`
  String get addTransactionLocationFieldHint {
    return Intl.message(
      'Tap to select location',
      name: 'addTransactionLocationFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get addTransactionLocationViewTitle {
    return Intl.message(
      'Select location',
      name: 'addTransactionLocationViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get addTransactionLocationViewSelectButton {
    return Intl.message(
      'Select',
      name: 'addTransactionLocationViewSelectButton',
      desc: '',
      args: [],
    );
  }

  /// `Location selection cancelled`
  String get addTransactionSnackBarLocationSelectCancelled {
    return Intl.message(
      'Location selection cancelled',
      name: 'addTransactionSnackBarLocationSelectCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Select current location`
  String get addTransactionLocationMenuCurrent {
    return Intl.message(
      'Select current location',
      name: 'addTransactionLocationMenuCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Select on map`
  String get addTransactionLocationMenuFromMap {
    return Intl.message(
      'Select on map',
      name: 'addTransactionLocationMenuFromMap',
      desc: '',
      args: [],
    );
  }

  /// `Cancel selection`
  String get addTransactionLocationMenuCancel {
    return Intl.message(
      'Cancel selection',
      name: 'addTransactionLocationMenuCancel',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get addTransactionSnackBarSuccessMessage {
    return Intl.message(
      'Saved',
      name: 'addTransactionSnackBarSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get statsViewButtonStats {
    return Intl.message(
      'Stats',
      name: 'statsViewButtonStats',
      desc: '',
      args: [],
    );
  }

  /// `Budget`
  String get statsViewButtonBudget {
    return Intl.message(
      'Budget',
      name: 'statsViewButtonBudget',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get statsViewButtonNote {
    return Intl.message(
      'Note',
      name: 'statsViewButtonNote',
      desc: '',
      args: [],
    );
  }

  /// `Chart`
  String get statsViewChartTab {
    return Intl.message(
      'Chart',
      name: 'statsViewChartTab',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get statsViewMapTab {
    return Intl.message(
      'Map',
      name: 'statsViewMapTab',
      desc: '',
      args: [],
    );
  }

  /// `Remaining (Monthly)`
  String get statsBudgetViewRemainingMonthlyTitle {
    return Intl.message(
      'Remaining (Monthly)',
      name: 'statsBudgetViewRemainingMonthlyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Budget Settings`
  String get statsBudgetViewBudgetSettingsTitle {
    return Intl.message(
      'Budget Settings',
      name: 'statsBudgetViewBudgetSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct value`
  String get statsBudgetSetupFieldValidatorIncorrect {
    return Intl.message(
      'Enter correct value',
      name: 'statsBudgetSetupFieldValidatorIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Remaining (Monthly)`
  String get statsBudgetMonthlyRemainingTitle {
    return Intl.message(
      'Remaining (Monthly)',
      name: 'statsBudgetMonthlyRemainingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get statsBudgetMonthlyTotalTitle {
    return Intl.message(
      'Monthly',
      name: 'statsBudgetMonthlyTotalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get statsBudgetSetupSaveButton {
    return Intl.message(
      'Save',
      name: 'statsBudgetSetupSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Enter desired budget`
  String get statsBudgetSetupSaveDescription {
    return Intl.message(
      'Enter desired budget',
      name: 'statsBudgetSetupSaveDescription',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get categoriesDefaultOther {
    return Intl.message(
      'Other',
      name: 'categoriesDefaultOther',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchExpensesSearchTitle {
    return Intl.message(
      'Search',
      name: 'searchExpensesSearchTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get searchExpensesAllCheckbox {
    return Intl.message(
      'All',
      name: 'searchExpensesAllCheckbox',
      desc: '',
      args: [],
    );
  }

  /// `Sub Currency Setting`
  String get subCurrencySettingTitle {
    return Intl.message(
      'Sub Currency Setting',
      name: 'subCurrencySettingTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
