import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:radency_internship_project_2/blocs/sign_up/sign_up_email/sign_up_email_bloc.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

import '../../generated/l10n.dart';

class EmailCodePage extends StatefulWidget {
  const EmailCodePage({Key? key}) : super(key: key);

  @override
  State<EmailCodePage> createState() => _EmailCodePageState();
}

class _EmailCodePageState extends State<EmailCodePage> {
  final TextEditingController _codeController = TextEditingController();

  bool _codeState = false;
  bool _resendState = true;
  bool _hasError = false;

  Timer? resendCoolDown;

  @override
  void dispose() {
    super.dispose();
    resendCoolDown?.cancel();
    resendCoolDown = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.signUpPageTitle),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.loginPage, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<SignUpEmailBloc, SignUpEmailState>(
        builder: (context, state) {
          if (state.signUpCodeConfirmation) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "S.current.verificationCodeTitle",
                        // style: h2(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "S.current.verificationCodeText",
                        style: regularTextStyle,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Pinput(
                          onChanged: (value) {
                            if (_hasError) {
                              _hasError = false;
                              setState(() {});
                            }
                          },
                          focusedPinTheme:
                              _pinTheme(borderColor: Colors.deepPurple),
                          defaultPinTheme: _pinTheme(
                              borderColor: _hasError
                                  ? Colors.red
                                  : Colors.white),
                          controller: _codeController,
                          onCompleted: (value) {
                            _codeState = true;
                            // _checkCode(state);
                            setState(() {});
                          },
                        ),
                      ),
                      if (_hasError) ...[
                        const SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: Text(
                            "S.current.verificationCodeWrongCodeTitle",
                            style: regularTextStyle.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 58,
                        child: ColoredElevatedButton(
                          child: Text("S.current.verificationCodeSubmitButtonTitle"),
                            onPressed: state.areDetailsProcessing ? null : () {
                              _checkCode(state);
                            },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "S.current.verificationCodeDidntReceiveTitle",
                            style: regular(),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              // context
                              //     .read<AuthServiceBloc>()
                              //     .add(AuthServiceResendVerificationCode());
                              _resendState = false;
                              setState(() {});
                              resendCoolDown =
                                  Timer(const Duration(seconds: 10), () {
                                _resendState = true;
                                setState(() {});
                              });
                            },
                            child: Text(
                              "S.current.verificationCodeResendTitle",
                              style: regular(
                                  color: _resendState
                                      ? Colors.deepPurpleAccent
                                      : Colors.grey),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void _checkCode(SignUpEmailState state) {
    // if (state.code != _codeController.text) {
    //   _hasError = true;
    //   setState(() {});
    // } else {
    //   if (state.signUpCodeConfirmation) {
    //     context
    //         .read<AuthServiceBloc>()
    //         .add(AuthServiceCheckVerificationCode(code: _codeController.text));
    //   } else {
    //     Navigator.of(context).pop();
    //   }
    // }
    context
        .read<SignUpEmailBloc>()
        .add(SignUpEmailConfirm(code: _codeController.text));
  }

  PinTheme _pinTheme({Color borderColor = Colors.white}) {
    return PinTheme(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        textStyle: medium(
          size: 18,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(16.0)));
  }

  // Widget _submitButton() {
  //   return BlocBuilder<SignUpEmailBloc, SignUpEmailState>(
  //     builder: (context, state) {
  //       return Container(
  //         height: 50,
  //         width: double.infinity,
  //         child: ColoredElevatedButton(
  //           onPressed: state.areDetailsProcessing ? null : () {
  //             _saveForms();
  //
  //             setState(() {
  //               autovalidateMode = AutovalidateMode.always;
  //             });
  //
  //             if (_validateForms()) {
  //               context.read<SignUpEmailBloc>().add(SignUpEmailSubmitted(
  //                 email: _email,
  //                 password: _password,
  //                 username: _username,
  //                 biometricsPairingStatus: _biometricsPairingEnabled,
  //               ));
  //             }
  //           },
  //           child: state.areDetailsProcessing
  //               ? Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: CircularProgressIndicator(),
  //           )
  //               : Text(S.current.signUpApplyCredentialsButton),
  //         ),
  //       );
  //     },
  //   );
  // }
}
