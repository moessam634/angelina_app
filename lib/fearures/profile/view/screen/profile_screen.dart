import 'package:flutter/material.dart';
import '../../../../../core/styles/text_styles.dart';
import '../widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("الملف الشخصي", style: TextStyles.k24),
            automaticallyImplyLeading: false,
            centerTitle: true),
        body: ProfileBody(),
      ),
    );
  }
}
