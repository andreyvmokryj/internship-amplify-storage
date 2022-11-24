import 'package:flutter/material.dart';

class DateRangeSlider extends StatelessWidget {
  final String content;
  final void Function()? onBackPressed;
  final void Function()? onForwardPressed;

  DateRangeSlider({required this.content, this.onBackPressed, this.onForwardPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onBackPressed,
          icon: Icon(Icons.keyboard_arrow_left),
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryTextTheme.headline6?.color,
          ),
        ),
        IconButton(
          onPressed: onForwardPressed,
          icon: Icon(Icons.keyboard_arrow_right),
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
      ],
    );
  }
}
