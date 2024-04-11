import 'package:flutter/material.dart';

import 'button_view.dart';
import 'text_view.dart';

class AlertDialogView extends StatelessWidget {
  final String content;

  AlertDialogView({required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextView(text: content),
      actions: <Widget>[
        ButtonView(
          title: "OK",
          buttonType: ButtonType.soldButton,
          onClick: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
