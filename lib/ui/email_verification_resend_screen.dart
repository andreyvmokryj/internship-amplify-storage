import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';

class EmailVerificationResendScreen extends StatefulWidget {
  const EmailVerificationResendScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationResendScreenState createState() => _EmailVerificationResendScreenState();
}

class _EmailVerificationResendScreenState extends State<EmailVerificationResendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            S.current.emailVerificationTitle,
          ),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              // onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
              onPressed: () {},
            )
          ]),
      body: body(),
    );
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              S.current.emailVerificationNotice,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ColoredElevatedButton(
            child: Text(
              S.current.emailVerificationResendButton,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              // context.read<AuthenticationBloc>().add(AuthenticationEmailResendRequested());
            },
          ),
        ],
      ),
    );
  }
}
