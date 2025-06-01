import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem(
      {super.key,
      required this.image,
      required this.categoryName,
      this.textStyle, this.onTap});

  final String image, categoryName;
  final TextStyle? textStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 46.r,
            backgroundImage: AssetImage(image),
          ),
        ),
        SizedBox(height: 6.h),
        Flexible(
          child: Text(
            categoryName,
            style: textStyle ?? TextStyles.k12,
          ),
        )
      ],
    );
  }
}
