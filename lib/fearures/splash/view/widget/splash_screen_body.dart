import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/image_app.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1),
          duration: const Duration(milliseconds:2500 ),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsApp.kPrimaryColor, width: 1.5.w),
                ),
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImageApp.angelinaImage,
                  width: 65.w,
                  height: 65.h,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      );
  }
}
