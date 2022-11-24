import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/sign_up/sign_up_email/sign_up_email_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/biometric_credentials_service.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/ui/widgets/centered_scroll_view.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class EmailSignUpPage extends StatelessWidget {
  const EmailSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpEmailBloc>(
      create: (_) => SignUpEmailBloc(
        context.read<AmplifyAuthenticationService>(),
        context.read<BiometricCredentialsService>(),
      )..add(SignUpEmailInitialize()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.signUpPageTitle),
        ),
        body: EmailSignUpForm(),
      ),
    );
  }
}

class EmailSignUpForm extends StatefulWidget {
  const EmailSignUpForm({Key? key}) : super(key: key);

  @override
  _EmailSignUpFormState createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm> {
  static const double _padding = 0.0;

  String _email = "";
  String _username = "";
  String _password = "";
  String _passwordConfirmation = "";
  bool _biometricsPairingEnabled = false;

  static final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _passwordConfirmationFormKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpEmailBloc, SignUpEmailState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
        }
      },
      builder: (context, state) {
        if (state.signUpFlowInitializationStatus) {
          return signUpContent();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget signUpContent() {
    return CenteredScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Text(
            S.current.signUpCreateAccountHeader,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          _detailsForms(),
        ],
      ),
    );
  }

  Widget _detailsForms() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailField(),
            _usernameField(),
            _passwordField(),
            _passwordConfirmationField(),
            _biometricsPairingCheckbox(),
          ],
        ),
        _submitButton(),
      ],
    );
  }

  Widget _emailField() {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Form(
        key: _emailFormKey,
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          keyboardType: TextInputType.emailAddress,
          initialValue: _email,
          cursorColor: accentColor,
          decoration: addTransactionFormFieldDecoration(
            context,
            hintText: S.current.signUpEmailLabelText,
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return S.current.signUpEmailValidatorEmpty;
            }

            if (!RegExp(emailRegExp).hasMatch(val)) {
              return S.current.signUpEmailValidatorIncorrect;
            }

            return null;
          },
          onSaved: (value) => _email = value ?? "",
        ),
      ),
    );
  }

  Widget _usernameField() {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Form(
        key: _usernameFormKey,
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          initialValue: _username,
          cursorColor: accentColor,
          decoration: addTransactionFormFieldDecoration(
            context,
            hintText: S.current.signUpUsernameLabelText,
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return S.current.signUpUsernameValidatorEmpty;
            }

            return null;
          },
          onSaved: (value) => _username = value ?? "",
        ),
      ),
    );
  }

  Widget _passwordField() {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Form(
        key: _passwordFormKey,
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          initialValue: _password,
          obscureText: true,
          cursorColor: accentColor,
          decoration: addTransactionFormFieldDecoration(
            context,
            hintText: S.current.signUpPasswordLabelText,
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return S.current.signUpPasswordValidatorEmpty;
            }

            return null;
          },
          onSaved: (value) => _password = value ?? "",
          onChanged: (value) {
            _password = value;
            _passwordConfirmationFormKey.currentState?.validate();
          },
        ),
      ),
    );
  }

  Widget _passwordConfirmationField() {
    final accentColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Form(
        key: _passwordConfirmationFormKey,
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          initialValue: _passwordConfirmation,
          obscureText: true,
          cursorColor: accentColor,
          decoration: addTransactionFormFieldDecoration(
            context,
            hintText: S.current.signUpPasswordConfirmationLabelText,
          ),
          validator: (val) {
            if (val != _password) {
              return S.current.signUpPasswordConfirmationValidatorNotMatch;
            }

            return null;
          },
          onSaved: (value) => _passwordConfirmation = value ?? "",
        ),
      ),
    );
  }

  Widget _biometricsPairingCheckbox() {
    return BlocBuilder<SignUpEmailBloc, SignUpEmailState>(builder: (context, state) {
      if (state.biometricsAvailable) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: _padding),
          child: Row(
            children: [
              Checkbox(
                  value: _biometricsPairingEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricsPairingEnabled = value ?? false;
                    });
                  }),
              Expanded(child: Text(S.current.authenticationBiometricsPairCheckbox)),
            ],
          ),
        );
      }

      return SizedBox();
    });
  }

  Widget _submitButton() {
    return BlocBuilder<SignUpEmailBloc, SignUpEmailState>(
      builder: (context, state) {
        return Container(
          height: 50,
          width: double.infinity,
          child: ColoredElevatedButton(
            onPressed: state.areDetailsProcessing ? null : () {
                    _saveForms();

                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });

                    if (_validateForms()) {
                      context.read<SignUpEmailBloc>().add(SignUpEmailSubmitted(
                            email: _email,
                            password: _password,
                            username: _username,
                            biometricsPairingStatus: _biometricsPairingEnabled,
                          ));
                    }
                  },
            child: state.areDetailsProcessing
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircularProgressIndicator(),
                  )
                : Text(S.current.signUpApplyCredentialsButton),
          ),
        );
      },
    );
  }

  void _saveForms() {
    _emailFormKey.currentState?.save();
    _usernameFormKey.currentState?.save();
    _passwordFormKey.currentState?.save();
    _passwordConfirmationFormKey.currentState?.save();
  }

  bool _validateForms() {
    bool result = true;

    if (!(_emailFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_usernameFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_passwordConfirmationFormKey.currentState?.validate() ?? false)) {
      result = false;
    }

    return result;
  }
}
