part of 'email_login_bloc.dart';

abstract class EmailLoginEvent extends Equatable {
  const EmailLoginEvent();
}

class EmailLoginInitialize extends EmailLoginEvent {
  @override
  List<Object> get props => [];
}

class EmailLoginSubmitted extends EmailLoginEvent {
  final String email;
  final String password;
  final bool pairWithBiometrics;

  EmailLoginSubmitted({required this.email, required this.password, required this.pairWithBiometrics});

  @override
  List<Object> get props => [email, password, pairWithBiometrics];
}

class EmailLoginBiometricRequested extends EmailLoginEvent {

  @override
  List<Object> get props => [];
}