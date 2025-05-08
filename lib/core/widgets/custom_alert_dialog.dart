import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsApp.kPrimaryColor,
      title: Text(
        title,
        // style: TextStyles.white16,
      ),
      actions: [
        TextButton(
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          child: Text(
            "OK",
            // style: TextStyles.white16,
          ),
        ),
      ],
    );
  }
}
