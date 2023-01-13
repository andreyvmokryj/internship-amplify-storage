import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:radency_internship_project_2/amplifyconfiguration.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/providers/amplify_api_provider.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/biometric_credentials_service.dart';
import 'package:radency_internship_project_2/providers/hive/hive_provider.dart';
import 'package:radency_internship_project_2/providers/mixpanel_service.dart';
import 'package:radency_internship_project_2/repositories/budgets_repository.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  await MixpanelService.init();

  var directory = await path_provider.getApplicationDocumentsDirectory();
  await HiveProvider().initializeHive(directory.path);

  AmplifyAuthenticationService amplifyAuthenticationService = AmplifyAuthenticationService();
  AmplifyApiProvider apiProvider = AmplifyApiProvider();
  TransactionsRepository transactionsRepository = TransactionsRepository(
      amplifyAuthenticationService: amplifyAuthenticationService);

  runApp(ProviderScope(
    child: Authenticator(
      child: App(
        amplifyAuthenticationService: amplifyAuthenticationService,
        apiProvider: apiProvider,
        biometricCredentialsService: BiometricCredentialsService(),
        budgetsRepository: BudgetsRepository(),
        transactionsRepository: transactionsRepository,
      ),
    ),
  ));
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));
  final auth = AmplifyAuthCognito();
  await Amplify.addPlugin(auth);

  // Once Plugins are added, configure Amplify
  await Amplify.configure(amplifyconfig);
}
