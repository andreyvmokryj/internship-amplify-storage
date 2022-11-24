part of 'sign_up_email_bloc.dart';

abstract class SignUpEmailEvent extends Equatable {
  const SignUpEmailEvent();
}

class SignUpEmailInitialize extends SignUpEmailEvent {
  @override
  List<Object> get props => [];
}

class SignUpEmailSubmitted extends SignUpEmailEvent {
  final String email;
  final String password;
  final String username;
  final bool biometricsPairingStatus;

  SignUpEmailSubmitted({required this.email, required this.password, required this.username, required this.biometricsPairingStatus});

  @override
  List<Object> get props => [email, password, username, biometricsPairingStatus];
}

class SignUpEmailConfirm extends SignUpEmailEvent {
  final String code;

  SignUpEmailConfirm({required this.code});

  @override
  List<Object> get props => [code];
}
