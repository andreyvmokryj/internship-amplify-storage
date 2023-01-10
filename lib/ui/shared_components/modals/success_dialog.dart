import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';

class _SuccessDialog extends StatefulWidget {
  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog> with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );

    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset("assets/animations/done.json",
              repeat: false,
              controller: lottieController,
              onLoaded: (composition) {
                lottieController.duration = composition.duration;
                lottieController.forward();
              }
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              S.current.addTransactionSnackBarSuccessMessage,
              style: TextStyle(
                color: Colors.green,
                fontSize: 21,
              ),
            ),
          ),
          const SizedBox(height: 14),
        ]
    );
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }
}

void showSuccessDialog(BuildContext context) => showDialog(
  context: context,
  builder: (context) => Dialog(child: _SuccessDialog()),
  barrierDismissible: false,
);