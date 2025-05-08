import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          height: 1,
          color: Colors.black,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(text, style: style),
        ),
        Expanded(
            child: Divider(
          height: 1,
          color: Colors.black,
        )),
      ],
    );
  }
}
