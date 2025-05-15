import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSize defaultAppBar({
  required BuildContext context,
  required Widget? title,
  List<Widget>? actions,
  double? height,
  double topPadding = 0,
  bool hasDrawer = false,
  bool showBack = false,
  Widget? leading,
}) {
  if (hasDrawer) {
    leading = Builder(
        builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(ImageApp.drawerIcon,
                fit: BoxFit.scaleDown,
                colorFilter:
                    ColorFilter.mode(ColorsApp.kBlackColor, BlendMode.srcIn))));
  } else if (showBack) {
    leading = IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  return PreferredSize(
    preferredSize: Size.fromHeight((height ?? 56.h) + topPadding),
    child: AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: height ?? 56.h,
      leading: leading,
      title: title,
      centerTitle: true,
      actions: actions,
      automaticallyImplyLeading: false,
    ),
  );
}
