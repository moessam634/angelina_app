import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Function(int)? onDotTap;

  const CustomCarouselIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isActive = currentIndex == index;
        return GestureDetector(
          onTap: onDotTap != null ? () => onDotTap!(index) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: isActive ? 8.h : 5.h,
            width: isActive ? 8.h : 5.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
              isActive ? ColorsApp.kSecondaryColor : ColorsApp.kThirdColor,
            ),
          ),
        );
      }),
    );
  }
}
