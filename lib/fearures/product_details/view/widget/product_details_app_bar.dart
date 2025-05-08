import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/image_app.dart';
import '../../../../core/widgets/custom_clickable_icon.dart';

class ProductDetailsAppBar extends StatelessWidget {
  const ProductDetailsAppBar({super.key, this.onPressed, this.imageUrl});

  final void Function()? onPressed;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 18.w, top: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomClickableIcon(
              width: 44.w,
              height: 44.h,
              icon: imageUrl,
              onPressed: onPressed,
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
