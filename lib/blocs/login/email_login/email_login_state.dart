part of 'email_login_bloc.dart';

class EmailLoginState extends Equatable {
  EmailLoginState({
    this.loginFlowInitialized = false,
    this.areDetailsProcessing = false,
    this.errorMessage,
    this.biometricsCredentialsEnrolled = false,
    this.savedEmail,
  });

  final bool loginFlowInitialized;
  final bool areDetailsProcessing;
  final String? errorMessage;
  final bool biometricsCredentialsEnrolled;
  final String? savedEmail;

  @override
  List<Object> get props {
    List<Object> _props = [areDetailsProcessing, loginFlowInitialized, biometricsCredentialsEnrolled];
    if (errorMessage != null) {
      _props.add(errorMessage!);
    }
    if (savedEmail != null) {
      _props.add(savedEmail!);
    }
    return _props;
  }

  EmailLoginState setInitializationState({
    required bool isInitialized,
    required bool biometricsCredentialsEnrolled,
  }) {
    return copyWith(
      loginFlowInitialized: isInitialized,
      biometricsCredentialsEnrolled: biometricsCredentialsEnrolled,
    );
  }

  EmailLoginState setDetailsProcessing() {
    return copyWith(areDetailsProcessing: true);
  }

  EmailLoginState showMessage({required String message}) {
    return copyWith(areDetailsProcessing: false, errorMessage: message);
  }

  EmailLoginState clearMessage() {
    return copyWith(errorMessage: null);
  }

  EmailLoginState setEmailValue({required String savedEmail}) {
    return copyWith(savedEmail: savedEmail);
  }

  EmailLoginState copyWith({
    bool? areDetailsProcessing,
    String? errorMessage,
    bool? loginFlowInitialized,
    bool? biometricsCredentialsEnrolled,
    String? savedEmail,
  }) {
    return EmailLoginState(
      areDetailsProcessing: areDetailsProcessing ?? this.areDetailsProcessing,
      errorMessage: errorMessage ?? null,
      loginFlowInitialized: loginFlowInitialized ?? this.loginFlowInitialized,
      biometricsCredentialsEnrolled: biometricsCredentialsEnrolled ?? this.biometricsCredentialsEnrolled,
      savedEmail: savedEmail ?? null,
    );
  }
}
