// part of 'sign_up_bloc.dart';
//
// enum PhoneSignUpPageMode { Credentials, OTP }
//
// class PhoneSignUpState extends Equatable {
//   const PhoneSignUpState({this.signUpPageMode = PhoneSignUpPageMode.Credentials, this.errorMessage, this.areDetailsProcessing = false, this.isOTPProcessing = false});
//
//   final PhoneSignUpPageMode signUpPageMode;
//   final String? errorMessage;
//   final bool areDetailsProcessing;
//   final bool isOTPProcessing;
//
//   @override
//   List<Object> get props {
//     List<Object> _props = [signUpPageMode, areDetailsProcessing, isOTPProcessing];
//     if(errorMessage != null) {
//       _props.add(errorMessage!);
//     }
//     return _props;
//   }
//
//   PhoneSignUpState onNumberProcessing() {
//     return copyWith(areDetailsProcessing: true);
//   }
//
//   PhoneSignUpState onWrongNumber() {
//     return copyWith(signUpPageMode: PhoneSignUpPageMode.Credentials);
//   }
//
//   PhoneSignUpState onNumberSubmitted() {
//     return copyWith(areDetailsProcessing: false, signUpPageMode: PhoneSignUpPageMode.OTP);
//   }
//
//   PhoneSignUpState onOtpStartProcessing() {
//     return copyWith(isOTPProcessing: true);
//   }
//
//   PhoneSignUpState showError(String message) {
//     return copyWith(errorMessage: message);
//   }
//
//   PhoneSignUpState copyWith({
//     PhoneSignUpPageMode? signUpPageMode,
//     String? errorMessage,
//     bool? areDetailsProcessing,
//     bool? isOTPProcessing,
//   }) {
//     return PhoneSignUpState(
//         signUpPageMode: signUpPageMode ?? this.signUpPageMode,
//         errorMessage: errorMessage ?? null,
//         areDetailsProcessing: areDetailsProcessing ?? false,
//         isOTPProcessing: isOTPProcessing ?? false);
//   }
// }
