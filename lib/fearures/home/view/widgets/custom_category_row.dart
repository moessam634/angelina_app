import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:flutter/material.dart';
import '../../../../core/styles/text_styles.dart';

class CustomCategoryRow extends StatelessWidget {
  const CustomCategoryRow(
      {super.key,
      required this.title,
      required this.more,
      this.onPressed,
      this.titleStyle,
      this.moreStyle});

  final String title, more;
  final void Function()? onPressed;
  final TextStyle? titleStyle, moreStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              TextStyles.k16.copyWith(color: ColorsApp.kBlackColor),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              more,
              style: moreStyle ??
                  TextStyles.k12.copyWith(color: ColorsApp.kPrimaryColor),
            ))
      ],
    );
  }
}
