import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckOutContainer extends StatelessWidget {
  const CustomCheckOutContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: .38.sh,
        decoration: ShapeDecoration(
          color: const Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.70,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: const Color(0x7FCCCCCC)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
          ),
        ),
        child: child);
  }
}
