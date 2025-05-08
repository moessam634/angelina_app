import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/text_styles.dart';

class CustomTotalPrice extends StatelessWidget {
  const CustomTotalPrice(
      {super.key, required this.totalPrice, required this.totalItems});

  final String totalPrice, totalItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFF1F4F4),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF9AADAF),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total price",
                  style: TextStyles.k22,
                ),
                Text(
                  "\$$totalPrice",
                  style: TextStyles.k22
                      .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  totalItems,
                  style:
                      TextStyles.k18.copyWith(color: ColorsApp.kLightGreyColor),
                ),
                Text(
                  r" items",
                  style:
                      TextStyles.k18.copyWith(color: ColorsApp.kLightGreyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
