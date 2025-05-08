import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText(
      {super.key,
      required this.text1,
      required this.text2,
      this.text1Style,
      this.text2Style});

  final String text1, text2;
  final TextStyle? text1Style, text2Style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: text1Style,
        ),
        Text(
          text2,
          style: text2Style,
        )
      ],
    );
  }
}
