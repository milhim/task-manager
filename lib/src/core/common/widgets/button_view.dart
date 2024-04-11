import 'package:flutter/material.dart';
import 'package:task_manager/src/core/common/widgets/text_view.dart';

enum ButtonType { soldButton, outlinedButton, textButton, iconButton, customElevatedButton, checkoutButton }

class ButtonView extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final ButtonType buttonType;
  final VoidCallback onClick;
  final ButtonStyle? buttonStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? width;
  final bool? isDisabled;
  final double? fontSize;

  final TextDecoration? textDecoration;

  const ButtonView({
    this.title,
    this.icon,
    this.fontSize,
    this.textDecoration,
    this.buttonStyle,
    required this.buttonType,
    required this.onClick,
    this.iconColor,
    this.textColor,
    this.width,
    this.isDisabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.soldButton:
        return soldButton(context);
      case ButtonType.outlinedButton:
        return outlineButton(context);
      case ButtonType.textButton:
        return textButton(context);
      case ButtonType.iconButton:
        return iconButton(context);
      case ButtonType.customElevatedButton:
        return customElevatedButton(context);
      case ButtonType.checkoutButton:
        return checkOutButton(context);
    }
  }

  Widget soldButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isDisabled ?? false ? null : onClick();
      },
      style: buttonStyle ??
          ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
              child: TextView(
                text: title ?? '',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget outlineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        isDisabled ?? false ? null : onClick();
      },
      style: buttonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          TextView(text: title ?? ''),
        ],
      ),
    );
  }

  Widget customElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isDisabled ?? false ? null : onClick();
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF538560),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 10,
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        title ?? '',
        style: TextStyle(color: textColor, decoration: textDecoration, fontSize: fontSize),
      ),
    );
  }

  Widget checkOutButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          isDisabled ?? false ? null : onClick();
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF538560),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          elevation: 10,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title ?? '',
              style: TextStyle(color: textColor, decoration: textDecoration, fontSize: fontSize),
            ),
            Icon(
              Icons.arrow_forward,
              color: textColor,
            ),
          ],
        ));
  }

  Widget textButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        isDisabled ?? false ? null : onClick();
      },
      style: buttonStyle,
      child: TextView(
        text: title ?? '',
        style: TextStyle(color: textColor),
      ),
    );
  }

  Widget iconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        isDisabled ?? false ? null : onClick();
      },
      icon: Icon(
        icon ?? Icons.add_box,
        color: iconColor,
      ),
    );
  }
}
