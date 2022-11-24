// part of 'sign_up_bloc.dart';
//
// abstract class PhoneSignUpEvent extends Equatable {
//   const PhoneSignUpEvent();
// }
//
// class SignUpCredentialsSubmitted extends PhoneSignUpEvent {
//   final String phoneNumber;
//   final String email;
//   final String username;
//
//   SignUpCredentialsSubmitted({required this.phoneNumber, required this.email, required this.username});
//
//   @override
//   List<Object> get props => [phoneNumber, email, username];
// }
//
// class SignUpOtpSubmitted extends PhoneSignUpEvent {
//   final String oneTimePassword;
//
//   SignUpOtpSubmitted({required this.oneTimePassword});
//
//   @override
//   List<Object> get props => [oneTimePassword];
// }
//
// class SignUpWrongNumberPressed extends PhoneSignUpEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class SignUpSignInWithPhoneCredentialCalled extends PhoneSignUpEvent {
//   final AuthCredential authCredential;
//
//   SignUpSignInWithPhoneCredentialCalled({required this.authCredential});
//
//   @override
//   List<Object> get props => [authCredential];
// }
//
// class SignUpCodeSent extends PhoneSignUpEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class SignUpVerificationFailed extends PhoneSignUpEvent {
//   final FirebaseAuthException exception;
//
//   SignUpVerificationFailed({required this.exception});
//
//   @override
//   List<Object> get props => [exception];
// }
