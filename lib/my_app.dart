import 'package:angelinashop/fearures/cart/view/screen/cart_screen.dart';
import 'package:angelinashop/fearures/home/view/screen/home_screen.dart';
import 'package:angelinashop/fearures/splash/view/screen/splash_screen.dart';
import 'package:angelinashop/fearures/switcher/view/screen/switcher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fearures/product_details/view/screen/product_details_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}
