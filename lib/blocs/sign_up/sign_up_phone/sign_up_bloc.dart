// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:radency_internship_project_2/providers/firebase_auth_service.dart';
//
// part 'sign_up_event.dart';
//
// part 'sign_up_state.dart';
//
// class PhoneSignUpBloc extends Bloc<PhoneSignUpEvent, PhoneSignUpState> {
//   PhoneSignUpBloc(this._authenticationService)
//       : super(const PhoneSignUpState());
//
//   final FirebaseAuthenticationService _authenticationService;
//
//   String? email;
//   String? username;
//   String? verificationId;
//   int? forceCodeResend;
//
//   @override
//   Stream<PhoneSignUpState> mapEventToState(
//     PhoneSignUpEvent event,
//   ) async* {
//     if (event is SignUpCredentialsSubmitted) {
//       yield* _mapSignUpCredentialsSubmittedToState(phoneNumber: event.phoneNumber, email: event.email, username: event.username);
//     } else if (event is SignUpOtpSubmitted) {
//       yield* _mapSignUpOtpSubmittedToState(oneTimePassword: event.oneTimePassword);
//     } else if (event is SignUpWrongNumberPressed) {
//       yield state.onWrongNumber();
//     } else if (event is SignUpSignInWithPhoneCredentialCalled) {
//       yield* _mapSignUpSignInWithPhoneCredentialAndUpdateProfileCalledToState(event.authCredential);
//     } else if (event is SignUpCodeSent) {
//       yield state.copyWith(areDetailsProcessing: false, signUpPageMode: PhoneSignUpPageMode.OTP);
//     } else if (event is SignUpVerificationFailed) {
//       yield state.copyWith(areDetailsProcessing: false, errorMessage: event.exception.message);
//     }
//   }
//
//   Stream<PhoneSignUpState> _mapSignUpCredentialsSubmittedToState({required String phoneNumber, required String email, required String username}) async* {
//     yield state.onNumberProcessing();
//
//     this.email = email;
//     this.username = username;
//
//     try {
//       await _authenticationService.startPhoneNumberAuthentication(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (AuthCredential phoneAuthCredential) {
//             print('PhoneAuthBloc: verificationCompleted');
//             add(SignUpSignInWithPhoneCredentialCalled(authCredential: phoneAuthCredential));
//           },
//           verificationFailed: (FirebaseAuthException exception) {
//             add(SignUpVerificationFailed(exception: exception));
//           },
//           codeSent: (String verId, [int? forceCodeResend]) {
//             print('PhoneAuthBloc: codeSent');
//             this.forceCodeResend = forceCodeResend;
//             verificationId = verId;
//             add(SignUpCodeSent());
//           },
//           forceResendingToken: forceCodeResend,
//           codeAutoRetrievalTimeout: (String verificationId) {});
//     } on PlatformException catch (e) {
//       yield state.copyWith(errorMessage: e.message);
//     }
//   }
//
//   Stream<PhoneSignUpState> _mapSignUpOtpSubmittedToState({required String oneTimePassword}) async* {
//     yield state.onOtpStartProcessing();
//
//     final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//       verificationId: verificationId!,
//       smsCode: oneTimePassword,
//     );
//
//     add(SignUpSignInWithPhoneCredentialCalled(authCredential: phoneAuthCredential));
//   }
//
//   Stream<PhoneSignUpState> _mapSignUpSignInWithPhoneCredentialAndUpdateProfileCalledToState(AuthCredential authCredential) async* {
//     try {
//       await _authenticationService.signInWithPhoneCredentialAndUpdateProfile(authCredential: authCredential, email: email, username: username);
//     } on PlatformException catch (e) {
//       yield state.showError(e.message ?? "");
//     } catch (e) {
//       yield state.showError(e.toString());
//     }
//   }
// }
