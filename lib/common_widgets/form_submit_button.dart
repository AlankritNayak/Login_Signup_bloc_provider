import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton(
      {@required String text,
      VoidCallback onPressed,
      Color color,
      Color textColor})
      : super(
            child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
        color: color,
        onPressed: onPressed,
        );
}
