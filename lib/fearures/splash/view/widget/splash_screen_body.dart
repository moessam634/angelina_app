import 'package:flutter/material.dart';
import '../../../../core/styles/image_app.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(ImageApp.angelinaImage),
      ),
    );
  }
}
