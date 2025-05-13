import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/colors_app.dart';
import '../../../../../core/styles/text_styles.dart';


class CustomRowItem extends StatelessWidget {
  const CustomRowItem({
    super.key,
    required this.leadingIcon,
    required this.text,
    this.textStyle,
    this.onTap,
    this.icon,
  });

  final IconData leadingIcon;
  final String text;
  final TextStyle? textStyle;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leadingIcon,
                color: ColorsApp.kPrimaryColor,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                text,
                style: textStyle ??
                    TextStyles.k18.copyWith(
                        fontWeight: FontWeight.w400, letterSpacing: 1.26),
              ),
            ],
          ),
          Icon(
            icon ?? Icons.arrow_forward_ios,
            size: 20,
          ),
        ],
      ),
    );
  }
}
