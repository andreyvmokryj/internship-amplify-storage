import 'dart:math';

import 'package:flutter/material.dart';

class CenteredScrollView extends StatelessWidget {
  const CenteredScrollView({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          constraints: BoxConstraints(maxWidth: min(400, MediaQuery.of(context).size.width * 0.8)),
          child: this.child,
        ),
      ),
    );
  }
}
