import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/favorite_body.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(
        context: context,
        height: 100.h,
        title: Text("المفضله", style: TextStyles.k24),
      ),
      body: FavoriteBody(),
    );
  }
}
