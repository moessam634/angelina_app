import 'package:angelinashop/fearures/switcher/view/screen/switcher_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/navigation_helper.dart';
import '../widget/splash_screen_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delayingFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: SplashScreenBody());
  }

  Future<void> delayingFunction() {
    return Future.delayed(
      Duration(seconds: 3),
      () {
        if (mounted) {
          NavigationHelper.pushUntil(
            context: context,
            destination: SwitcherScreen(),
          );
        }
      },
    );
  }
}
