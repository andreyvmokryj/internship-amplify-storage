import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/biometric_credentials_service.dart';

part 'email_login_event.dart';

part 'email_login_state.dart';

// Discontinued
class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  EmailLoginBloc(this._authenticationService, this._biometricCredentialsService)
      : super(EmailLoginState());

  final AmplifyAuthenticationService _authenticationService;
  final BiometricCredentialsService _biometricCredentialsService;

  @override
  Stream<EmailLoginState> mapEventToState(
    EmailLoginEvent event,
  ) async* {
    if (event is EmailLoginSubmitted) {
      yield* _mapEmailLoginSubmittedToState(
          email: event.email, password: event.password, shouldPairWithBiometrics: event.pairWithBiometrics);
    } else if (event is EmailLoginBiometricRequested) {
      yield* _mapEmailLoginBiometricRequestedToState();
    } else if (event is EmailLoginInitialize) {
      yield* _mapEmailLoginInitializeToState();
    }
  }

  Stream<EmailLoginState> _mapEmailLoginInitializeToState() async* {
    bool areBiometricsEnrolled = await _biometricCredentialsService.checkIfAnyBiometricsEnrolled();
    bool areBiometricsPairedToCredentials = false;
    String? biometricsPairedEmail;

    if (areBiometricsEnrolled) {
      areBiometricsPairedToCredentials = await _biometricCredentialsService.getCredentialsPairingStatus();
      if (areBiometricsPairedToCredentials) {
        biometricsPairedEmail =
            await _biometricCredentialsService.getCredentials(credentialType: BiometricCredentialsService().EMAIL_KEY);
      }
    }

    yield state.setInitializationState(
      isInitialized: true,
      biometricsCredentialsEnrolled: areBiometricsEnrolled,
    );

    if (biometricsPairedEmail != null) {
      //This delayed is required to apply state change
      await Future.delayed(Duration(milliseconds: 10));
      yield state.setEmailValue(savedEmail: biometricsPairedEmail);
    }

    if (areBiometricsPairedToCredentials) {
      add(EmailLoginBiometricRequested());
    }
  }

  Stream<EmailLoginState> _mapEmailLoginSubmittedToState({
    required String email,
    required String password,
    required bool shouldPairWithBiometrics,
  }) async* {
    yield state.setDetailsProcessing();

    bool didAuthenticateWithBiometrics = false;

    if (shouldPairWithBiometrics) {
      try {
        didAuthenticateWithBiometrics =
            await _biometricCredentialsService.authenticate(reason: S.current.authenticationBiometricsReasonSave);
        if (!didAuthenticateWithBiometrics) {
          yield state.showMessage(message: S.current.authenticationBiometricsFailure);
        }
      } on PlatformException catch (e) {
        yield state.showMessage(message: localizeLocalAuthError(e.code));
      }
    }

    if (didAuthenticateWithBiometrics || !shouldPairWithBiometrics) {
      try {
        await _authenticationService.signInWithEmailAndPassword(email: email, password: password);
        if (shouldPairWithBiometrics) {
          await _biometricCredentialsService.saveBiometricCredentials(email: email, password: password);
        }
      } catch (e) {
        yield state.showMessage(message: e.toString());
      }
    }
  }

  Stream<EmailLoginState> _mapEmailLoginBiometricRequestedToState() async* {
    bool didAuthenticate = false;
    try {
      didAuthenticate =
          await _biometricCredentialsService.authenticate(reason: S.current.authenticationBiometricsReasonRead);
    } on PlatformException catch (e) {
      yield state.showMessage(message: localizeLocalAuthError(e.code));
    }

    if (didAuthenticate) {
      String email = '';
      String password = '';

      email =
          await _biometricCredentialsService.getCredentials(credentialType: BiometricCredentialsService().EMAIL_KEY);
      password =
          await _biometricCredentialsService.getCredentials(credentialType: BiometricCredentialsService().PASSWORD_KEY);

      add(EmailLoginSubmitted(email: email, password: password, pairWithBiometrics: false));

      yield state.showMessage(message: S.current.authenticationBiometricsSuccessful(email));
      yield state.clearMessage();
    }
  }

  // TODO: consider moving into external helper

  //On Android, you can check only for existence of fingerprint hardware prior to API 29 (Android Q). Therefore,
  // if you would like to support other biometrics types (such as face scanning) and you want to support SDKs lower
  // than Q, do not call getAvailableBiometrics. Simply call authenticate with biometricOnly: true. This will return
  // an error if there was no hardware available.
  String localizeLocalAuthError(String message) {
    if (message == notAvailable) {
      return S.current.authenticationBiometricsErrorNotAvailable;
    } else if (message == notEnrolled) {
      return S.current.authenticationBiometricsErrorNotEnrolled;
    } else if (message == lockedOut) {
      return S.current.authenticationBiometricsErrorLockedOut;
    } else {
      return S.current.authenticationBiometricsErrorUnknownError;
    }
  }
}
