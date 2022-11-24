import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class SignUpFailure implements Exception {}

class LogInWithPhoneNumberFailure implements Exception {}

class SignUpWithPhoneNumberFailure implements Exception {
  final String message;

  SignUpWithPhoneNumberFailure({required this.message});
}

class LogOutFailure implements Exception {}

class AmplifyAuthenticationService {
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    await Amplify.Auth.signIn(
      username: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password, required String username}) async {
    final userAttributes = <CognitoUserAttributeKey, String>{
      CognitoUserAttributeKey.nickname: username,
      // CognitoUserAttributeKey.phoneNumber: '+15559101234',
      // additional attributes as needed
    };

    await Amplify.Auth.signUp(
      username: email,
      password: password,
      options: CognitoSignUpOptions(userAttributes: userAttributes),
    );

    await Amplify.Auth.signIn(username: email, password: password);
  }

  Future<void> confirmSignUp({required String email, required String code}) async {
    await Amplify.Auth.confirmSignUp(
      username: email,
      confirmationCode: code,
    );

  }

  Future<String> getUserID() async {
    AuthUser? user = await Amplify.Auth.getCurrentUser();
    return user.userId ?? "";
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        Amplify.Auth.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
