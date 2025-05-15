// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/styles/image_app.dart';
//
// class SplashScreenBody extends StatelessWidget {
//   const SplashScreenBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: ColoredBox(
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.all(18),
//             child: Image.asset(
//               ImageApp.angelinaImage,
//               width: 60.w,
//               height: 60.h,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1),
          duration: const Duration(seconds: 5),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsApp.kLightGreyColor, width: 2),
                ),
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  ImageApp.angelinaImage,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
