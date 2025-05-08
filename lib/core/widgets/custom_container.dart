import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.side,
    this.width,
    this.height,
    required this.child,
  });

  final BorderSide? side;
  final double? width, height;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 160.w,
      height: height ?? 30.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: side ??
              BorderSide(
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Colors.black.withValues(alpha: .16),
              ),
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: child,
    );
  }
}
