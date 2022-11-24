import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:radency_internship_project_2/blocs/accounts/account_bloc.dart';
import 'package:radency_internship_project_2/blocs/export_csv/export_csv_bloc.dart';
import 'package:radency_internship_project_2/blocs/forex/forex_bloc.dart';
import 'package:radency_internship_project_2/blocs/image_picker/image_picker_bloc.dart';
import 'package:radency_internship_project_2/blocs/navigation/navigation_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/styles/styles_bloc.dart';
import 'package:radency_internship_project_2/blocs/stats/stats_bloc.dart';
import 'package:radency_internship_project_2/blocs/sub_currency/sub_currency_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/transaction_location_map/transaction_location_map_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/transaction_type/transaction_type_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_calendar/transactions_calendar_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/transactions_summary/transactions_summary_bloc.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/biometric_credentials_service.dart';
import 'package:radency_internship_project_2/repositories/budgets_repository.dart';
import 'package:radency_internship_project_2/repositories/settings_repository/settings_repository.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/ui/category_page/category_page_add.dart';
import 'package:radency_internship_project_2/ui/category_page/expenses_catedory_list.dart';
import 'package:radency_internship_project_2/ui/category_page/income_catedory_list.dart';
import 'package:radency_internship_project_2/ui/email_login_page.dart';
import 'package:radency_internship_project_2/ui/email_sign_up_page.dart';
import 'package:radency_internship_project_2/ui/email_verification_resend_screen.dart';
import 'package:radency_internship_project_2/ui/onboarding_page.dart';
import 'package:radency_internship_project_2/ui/search_expenses_page/search_expenses_page_template.dart';
import 'package:radency_internship_project_2/ui/settings_components/settings_subpages/language_setting_page.dart';
import 'package:radency_internship_project_2/ui/settings_components/settings_subpages/style_setting_page.dart';
import 'package:radency_internship_project_2/ui/widgets/add_transaction_view/add_transaction_page.dart';
import 'package:radency_internship_project_2/ui/widgets/add_transaction_view/transaction_location_select_view.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/stats_view.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/budget_overview/budget_settings_page.dart';
import 'package:radency_internship_project_2/ui/widgets/stats_view/tabs/budget_overview/category_budget_setup_view.dart';
import 'blocs/settings/category/category_bloc.dart';
import 'blocs/settings/category/category_slider/category_slider_bloc.dart';
import 'blocs/stats/budget_overview/budget_overview_bloc.dart';
import 'blocs/stats/expenses_chart/expenses_chart_bloc.dart';
import 'blocs/stats/expenses_map/expenses_map_bloc.dart';
import 'blocs/transactions/search_transactions/search_transactions_bloc.dart';
import 'blocs/transactions/transactions_daily/transactions_daily_bloc.dart';
import 'blocs/transactions/transactions_monthly/transactions_monthly_bloc.dart';
import 'blocs/transactions/transactions_slider/transactions_slider_bloc.dart';
import 'blocs/transactions/transactions_weekly/transactions_weekly_bloc.dart';
import 'blocs/user_profile/user_profile_bloc.dart';
import 'generated/l10n.dart';
import 'ui/home_page.dart';
import 'ui/settings_components/settings_subpages/currency_setting_page.dart';
import 'ui/settings_page.dart';
import 'utils/routes.dart';
import 'utils/styles.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.amplifyAuthenticationService,
    required this.budgetsRepository,
    required this.biometricCredentialsService,
    required this.transactionsRepository,
  })  : super(key: key);

  final AmplifyAuthenticationService amplifyAuthenticationService;
  final BudgetsRepository budgetsRepository;
  final BiometricCredentialsService biometricCredentialsService;
  final TransactionsRepository transactionsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: amplifyAuthenticationService),
          RepositoryProvider.value(value: biometricCredentialsService),
          RepositoryProvider.value(value: budgetsRepository),
          RepositoryProvider.value(value: transactionsRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SettingsBloc(SettingsRepository())..add(InitialSettingsEvent()),
            ),
            BlocProvider(
              create: (context) => UserProfileBloc(),
            ),
            BlocProvider(
              create: (context) => StylesBloc(),
            ),
            BlocProvider(
              create: (context) => CategoryBloc(),
            ),
            BlocProvider(
              create: (_) => ImagePickerBloc(transactionsRepository: transactionsRepository),
            ),
            BlocProvider(
              create: (_) => NavigationBloc()..add(SelectPage(0)),
            ),
            BlocProvider(
              create: (context) => StatsBloc(),
            ),
            BlocProvider(
              create: (context) => TransactionLocationMapBloc(),
            ),
            BlocProvider(create: (_) => CsvExportBloc(transactionsRepository: transactionsRepository)),
            BlocProvider(
              create: (context) => TransactionsDailyBloc(
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                transactionsRepository: transactionsRepository,
              )..add(TransactionsDailyInitialize()),
            ),
            BlocProvider(
              create: (context) => TransactionsWeeklyBloc(
                  transactionsRepository: transactionsRepository)
                ..add(TransactionsWeeklyInitialize()),
            ),
            BlocProvider(
              create: (context) => TransactionsMonthlyBloc(
                transactionsRepository: transactionsRepository,
              )..add(TransactionsMonthlyInitialize()),
            ),
            BlocProvider(
              create: (context) => TransactionsSummaryBloc(
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                transactionsRepository: transactionsRepository,
              )..add(TransactionsSummaryInitialize()),
            ),
            BlocProvider(
              create: (context) => TransactionsCalendarBloc(
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                transactionsRepository: transactionsRepository,
              )..add(TransactionsCalendarInitialize()),
            ),
            BlocProvider(
              create: (context) => BudgetOverviewBloc(
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                budgetsRepository: budgetsRepository,
                transactionsRepository: transactionsRepository,
              )..add(BudgetOverviewInitialize()),
            ),
            BlocProvider(create: (context) => TransactionLocationMapBloc()),
            BlocProvider(
              create: (context) => ExpensesMapBloc(
                stylesBloc: BlocProvider.of<StylesBloc>(context),
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                transactionsRepository: transactionsRepository,
              )..add(ExpensesMapInitialize()),
            ),
            BlocProvider(
              create: (context) => ExpensesChartBloc(
                settingsBloc: BlocProvider.of<SettingsBloc>(context),
                transactionsRepository: transactionsRepository,
              )..add(ExpensesChartInitialize()),
            ),
            BlocProvider<TransactionsSliderBloc>(
              create: (context) => TransactionsSliderBloc()..add(TransactionsSliderInitialize()),
            ),
            BlocProvider(
              create: (_) => SearchTransactionsBloc()..add(SearchTransactionsInitialize()),
            ),
            BlocProvider(
              create: (context) => CategorySliderBloc()..add(CategorySliderInitialize()),
            ),
            BlocProvider(
              create: (context) => AccountBloc()..add(FetchAccounts()),
            ),
            BlocProvider(
              create: (context) => SubCurrencyBloc()..add(SubCurrencyInitialize()),
            ),
            BlocProvider(
              create: (context) => ForexBloc(),
            ),
            BlocProvider(
              create: (context) => TransactionTypeBloc(),
            )
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, settingsState) {
      String language = settingsState.language;
      return BlocBuilder<StylesBloc, StylesState>(builder: (BuildContext context, stylesState) {
        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ru', ''),
          ],
          locale: Locale(language),
          navigatorKey: _navigatorKey,
          themeMode: getThemeMode(stylesState.theme),
          theme: Styles.themeData(context, false, stylesState.themeColors),
          darkTheme: Styles.themeData(context, true, stylesState.themeColors),
          routes: {
            Routes.onboardingPage: (context) => OnboardingPage(),
            Routes.loginPage: (context) => EmailLoginPage(),
            Routes.homePage: (context) => HomePage(),
            Routes.signUpPage: (context) => EmailSignUpPage(),
            Routes.splashScreen: (context) => HomePage(),
            Routes.statsPage: (context) => StatsView(),
            Routes.budgetSettings: (context) => BudgetSettingsPage(),
            Routes.settingsPage: (context) => SettingsPage(),
            Routes.currencySettingPage: (context) => CurrencySettingPage(),
            Routes.addTransactionPage: (context) => AddTransactionPage(),
            Routes.categoryBudgetSetupView: (context) => CategoryBudgetSetupView(),
            Routes.languageSettingPage: (context) => LanguageSettingPage(),
            Routes.styleSettingPage: (context) => StyleSettingPage(),
            Routes.transactionLocationSelectView: (context) => TransactionLocationSelectView(),
            Routes.incomeCategoriesPage: (context) => IncomeCategoriesPage(),
            Routes.expensesCategoriesPage: (context) => ExpensesCategoriesPage(),
            Routes.newCategoryPage: (context) => NewCategoryPage(),
            Routes.emailVerificationResendPage: (context) => EmailVerificationResendScreen(),
            Routes.searchExpensesPage: (context) => SearchExpensesPage(),
          },
          builder: Authenticator.builder(),
        );
      });
    });
  }
}
