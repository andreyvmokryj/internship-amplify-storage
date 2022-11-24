import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

import 'hive/hive_provider.dart';

class BiometricCredentialsService {
  final String CEDENTIALS_PAIRING_STATUS_KEY = 'credentialsPairingStatus';
  final String EMAIL_KEY = 'email';
  final String PASSWORD_KEY = 'password';

  var localAuth = LocalAuthentication();

  //TODO: implement iOS integration https://pub.dev/packages/local_auth

  //  Several issues/PRs related to local auth:

  // https://github.com/flutter/plugins/pull/3763
  // https://github.com/flutter/flutter/issues/45497
  // https://github.com/flutter/flutter/issues/45775
  // https://github.com/flutter/flutter/issues/29457

  // Fingerprint is used by default

  Future<void> saveBiometricCredentials({required String email, required String password}) async {
    Box box = await HiveProvider().openCredentialsBox();

    await box.put(EMAIL_KEY, email);
    await box.put(PASSWORD_KEY, password);
    await box.put(CEDENTIALS_PAIRING_STATUS_KEY, true);
  }

  Future<void> clearBiometricCredentials() async {
    Box box = await HiveProvider().openCredentialsBox();

    await box.delete(EMAIL_KEY);
    await box.delete(PASSWORD_KEY);
    await box.put(CEDENTIALS_PAIRING_STATUS_KEY, false);
  }

  Future<bool> getCredentialsPairingStatus() async {
    Box box = await HiveProvider().openCredentialsBox();

    bool status = await box.get(CEDENTIALS_PAIRING_STATUS_KEY, defaultValue: false);
    return status;
  }

  Future<String> getCredentials({required String credentialType}) async {
    Box box = await HiveProvider().openCredentialsBox();

    String value = await box.get(credentialType, defaultValue: null);
    return value;
  }

  Future<bool> checkIfAnyBiometricsEnrolled() async {
    List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
    print("BiometricCredentialsService.checkIfAnyBiometricsEnrolled: $availableBiometrics");

    if (availableBiometrics.contains(BiometricType.fingerprint) || availableBiometrics.contains(BiometricType.face)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> authenticate({required String reason}) async {
    return localAuth.authenticate(localizedReason: reason, biometricOnly: true);
  }
}
