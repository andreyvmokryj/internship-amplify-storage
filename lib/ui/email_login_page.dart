import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/login/email_login/email_login_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/biometric_credentials_service.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/ui/widgets/centered_scroll_view.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class EmailLoginPage extends StatelessWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<EmailLoginBloc>(
          create: (_) =>
              EmailLoginBloc(context.read<AmplifyAuthenticationService>(), context.read<BiometricCredentialsService>())
                ..add(EmailLoginInitialize()),
          child: EmailLoginForm(),
        ),
      ),
    );
  }
}

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({Key? key}) : super(key: key);

  @override
  _EmailLoginFormState createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  static const double _padding = 0.0;

  String _email = "";
  String _password = "";
  bool _biometricsPairingEnabled = false;

  static final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailLoginBloc, EmailLoginState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
        }

        if (state.savedEmail != null) {
          _emailController.text = state.savedEmail!;
          _email = state.savedEmail!;
        }
      },
      builder: (context, state) {
        if (state.loginFlowInitialized) {
          return loginContent();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget loginContent() {
    return CenteredScrollView(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Image.asset(
              'assets/images/Wallet.png',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            S.current.loginWelcomeText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            S.current.loginNoticeText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          _loginForms(),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                _biometricsPairingCheckbox(),
                forgotButton(),
              ],
            ),
          ),
          _submitButton(),
          _newAccountSection(),
        ],
      ),
    );
  }

  Widget _loginForms() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailField(),
            _passwordField(),
          ],
        ),
      ],
    );
  }

  Widget forgotButton() {
    return TextButton(
      child: Text(S.current.loginForgotPasswordButton),
      onPressed: () {
        // TODO: implement password restore
      },
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _newAccountSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(S.current.loginNoAccountNotice),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(S.current.loginCreateAccountButton),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.signUpPage);
          },
        ),
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
          controller: _emailController,
          cursorColor: accentColor,
          decoration: addTransactionFormFieldDecoration(context,
              hintText: S.current.loginEmailLabelText,
              prefixIcon: Icon(
                Icons.email,
                color: accentColor,
              ),
              prefixWidth: 50),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return S.current.loginEmailValidatorEmpty;
            }

            if (!RegExp(emailRegExp).hasMatch(val)) {
              return S.current.loginEmailValidatorIncorrect;
            }

            return null;
          },
          onSaved: (value) => _email,
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
          decoration: addTransactionFormFieldDecoration(context,
              hintText: S.current.loginPasswordLabelText,
              prefixIcon: Icon(
                Icons.lock,
                color: accentColor,
              ),
              prefixWidth: 50),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return S.current.loginPasswordValidatorEmpty;
            }

            return null;
          },
          onSaved: (value) => _password = value ?? "",
        ),
      ),
    );
  }

  Widget _submitButton() {
    return BlocBuilder<EmailLoginBloc, EmailLoginState>(
      builder: (context, state) {
        return Container(
          height: 50,
          width: double.infinity,
          child: ColoredElevatedButton(
            onPressed: state.areDetailsProcessing
                ? null
                : () {
                    _saveForms();

                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });

                    if (_validateForms()) {
                      context.read<EmailLoginBloc>().add(EmailLoginSubmitted(
                            email: _email,
                            password: _password,
                            pairWithBiometrics: _biometricsPairingEnabled,
                          ));
                    }
                  },
            child: state.areDetailsProcessing
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircularProgressIndicator(),
                  )
                : Text(S.current.loginSubmitButton),
          ),
        );
      },
    );
  }

  Widget _biometricsPairingCheckbox() {
    return BlocBuilder<EmailLoginBloc, EmailLoginState>(builder: (context, state) {
      if (state.biometricsCredentialsEnrolled) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: _padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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

  void _saveForms() {
    _emailFormKey.currentState?.save();
    _passwordFormKey.currentState?.save();
  }

  bool _validateForms() {
    bool result = true;

    if (!(_emailFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      result = false;
    }

    return result;
  }
}
