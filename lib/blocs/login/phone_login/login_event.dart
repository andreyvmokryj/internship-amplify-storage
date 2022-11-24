// part of 'login_bloc.dart';
//
// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
//
// }
//
// class LoginCredentialsSubmitted extends LoginEvent {
//
//   final String phoneNumber;
//
//   LoginCredentialsSubmitted({required this.phoneNumber});
//
//   @override
//   List<Object> get props => [phoneNumber];
// }
//
// class LoginOtpSubmitted extends LoginEvent {
//
//   final String oneTimePassword;
//
//   LoginOtpSubmitted({required this.oneTimePassword});
//
//   @override
//   List<Object> get props => [oneTimePassword];
// }
//
// class LoginWrongNumberPressed extends LoginEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class LoginSignInWithPhoneCredentialCalled extends LoginEvent {
//   final AuthCredential authCredential;
//
//   LoginSignInWithPhoneCredentialCalled({required this.authCredential});
//
//   @override
//   List<Object> get props => [authCredential];
// }
//
// class LoginCodeSent extends LoginEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class LoginVerificationFailed extends LoginEvent {
//
//   final FirebaseAuthException exception;
//
//   LoginVerificationFailed({required this.exception});
//
//
//   @override
//   List<Object> get props => [exception];
// }
//
