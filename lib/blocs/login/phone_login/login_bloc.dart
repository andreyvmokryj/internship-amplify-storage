// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:radency_internship_project_2/providers/firebase_auth_service.dart';
//
// part 'login_event.dart';
// part 'login_state.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc(this._authenticationService)
//       : super(const LoginState());
//
//   final FirebaseAuthenticationService _authenticationService;
//
//   String? verificationId;
//   int? forceCodeResend;
//
//   @override
//   Stream<LoginState> mapEventToState(
//     LoginEvent event,
//   ) async* {
//     if (event is LoginCredentialsSubmitted) {
//       yield* _mapLoginCredentialsSubmittedToState(phoneNumber: event.phoneNumber);
//     } else if (event is LoginOtpSubmitted) {
//       yield* _mapLoginOtpSubmittedToState(oneTimePassword: event.oneTimePassword);
//     } else if (event is LoginWrongNumberPressed) {
//       yield state.onWrongNumber();
//     } else if (event is LoginSignInWithPhoneCredentialCalled) {
//       yield* _mapLoginSignInWithPhoneCredentialCalledToState(event.authCredential);
//     } else if (event is LoginCodeSent) {
//       yield state.copyWith(areDetailsProcessing: false, loginPageMode: LoginPageMode.OTP);
//     } else if (event is LoginVerificationFailed) {
//       yield state.copyWith(areDetailsProcessing: false, errorMessage: event.exception.message);
//     }
//   }
//
//   Stream<LoginState> _mapLoginCredentialsSubmittedToState({
//     required String phoneNumber,
//   }) async* {
//     yield state.onNumberProcessing();
//
//     try {
//       await _authenticationService.startPhoneNumberAuthentication(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (AuthCredential phoneAuthCredential) {
//             print('PhoneAuthBloc: verificationCompleted');
//             add(LoginSignInWithPhoneCredentialCalled(authCredential: phoneAuthCredential));
//           },
//           verificationFailed: (FirebaseAuthException exception) {
//             add(LoginVerificationFailed(exception: exception));
//           },
//           codeSent: (String verificationId, [int? forceCodeResend]) {
//             print('PhoneAuthBloc: codeSent');
//             this.forceCodeResend = forceCodeResend;
//             this.verificationId = verificationId;
//             add(LoginCodeSent());
//           },
//           forceResendingToken: forceCodeResend,
//           codeAutoRetrievalTimeout: (String verificationId) {});
//     } on PlatformException catch (e) {
//       yield state.copyWith(errorMessage: e.message);
//     }
//   }
//
//   Stream<LoginState> _mapLoginOtpSubmittedToState({required String oneTimePassword}) async* {
//     yield state.onOtpStartProcessing();
//
//     final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//       verificationId: verificationId!,
//       smsCode: oneTimePassword,
//     );
//
//     add(LoginSignInWithPhoneCredentialCalled(authCredential: phoneAuthCredential));
//   }
//
//   Stream<LoginState> _mapLoginSignInWithPhoneCredentialCalledToState(AuthCredential authCredential) async* {
//     try {
//       await _authenticationService.signInWithPhoneCredential(authCredential: authCredential);
//     } on PlatformException catch (e) {
//       yield state.showError(e.message!);
//     } catch (e) {
//       yield state.showError(e.toString());
//     }
//   }
// }
