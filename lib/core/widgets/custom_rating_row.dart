import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class CustomRatingRow extends StatelessWidget {
  const CustomRatingRow({super.key, this.iconSize, this.rate, this.textStyle});

  final double? iconSize;
  final String? rate;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
        textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Icon(
            Icons.star,
            color: ColorsApp.kPrimaryColor,
            size: iconSize ?? 12.sp,
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
        Flexible(
          child: Text(rate ?? "(4.5)",
              style: textStyle ??
                  TextStyles.k12.copyWith(color: ColorsApp.kPrimaryColor)),
        ),
      ],
    );
  }
}
