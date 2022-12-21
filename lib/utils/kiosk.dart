import 'dart:io';

import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/ui_utils.dart';

void handleStart(BuildContext context, bool didStart) {
  if (!didStart && Platform.isIOS) {
    showSnackBarMessage(
      context,
      'Single App mode is supported only for devices that are supervised'
          ' using Mobile Device Management (MDM) and the app itself must'
          ' be enabled for this mode by MDM.',
    );
  }
}

void handleStop(BuildContext context, bool? didStop) {
  if (didStop == false) {
    showSnackBarMessage(
      context,
      'Kiosk mode could not be stopped or was not active to begin with.',
    );
  }
}