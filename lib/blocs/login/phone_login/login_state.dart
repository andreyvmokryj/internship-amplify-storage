// part of 'login_bloc.dart';
//
// enum LoginPageMode { Credentials, OTP }
//
// class LoginState extends Equatable {
//   const LoginState({this.loginPageMode = LoginPageMode.Credentials, this.errorMessage, this.areDetailsProcessing = false, this.isOTPProcessing = false});
//
//   final LoginPageMode loginPageMode;
//   final String? errorMessage;
//   final bool areDetailsProcessing;
//   final bool isOTPProcessing;
//
//   @override
//   List<Object> get props => [loginPageMode, errorMessage ?? "", areDetailsProcessing, isOTPProcessing];
//
//   LoginState onNumberProcessing() {
//     return copyWith(areDetailsProcessing: true);
//   }
//
//   LoginState onWrongNumber() {
//     return copyWith(loginPageMode: LoginPageMode.Credentials);
//   }
//
//   LoginState onNumberSubmitted() {
//     return copyWith(areDetailsProcessing: false, loginPageMode: LoginPageMode.OTP);
//   }
//
//   LoginState onOtpStartProcessing () {
//     return copyWith(isOTPProcessing: true);
//   }
//
//   LoginState showError(String message) {
//     return copyWith(errorMessage: message);
//   }
//
//   LoginState copyWith({
//     LoginPageMode? loginPageMode,
//     String? errorMessage,
//     bool? areDetailsProcessing,
//     bool? isOTPProcessing,
//   }) {
//     return LoginState(
//         loginPageMode: loginPageMode ?? this.loginPageMode,
//         errorMessage: errorMessage ?? null,
//         areDetailsProcessing: areDetailsProcessing ?? false,
//         isOTPProcessing: isOTPProcessing ?? false);
//   }
// }
