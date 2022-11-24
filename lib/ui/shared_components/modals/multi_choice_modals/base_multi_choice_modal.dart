import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class BaseMultiChoiceModal extends StatelessWidget{
  final String title;
  final Widget child;
  final onOKCallback;
  final onCancelCallback;

  const BaseMultiChoiceModal({Key? key, required this.title, required this.child, this.onOKCallback, this.onCancelCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        bottom: 30,
        left: 30,
        right: 30,
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 25,
                      bottom: 20,
                      left: 20,
                    ),
                    child: Text(
                      title,
                      style: searchModalTitleStyle(context),
                    ),
                  ),
                  Divider(
                    thickness: 1.1,
                  ),
                  Expanded(
                    child: child
                  ),
                ],
              )
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        S.current.cancel,
                        style: buttonTitleStyle(context),
                      ),
                      onPressed: onCancelCallback,
                    )
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "OK",
                        style: buttonTitleStyle(context, Theme.of(context).accentColor)
                      ),
                      onPressed: onOKCallback,
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}