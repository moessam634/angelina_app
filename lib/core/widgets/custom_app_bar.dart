import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSize defaultAppBar({
  required BuildContext context,
  required Widget? title,
  Widget? leading,
  List<Widget>? actions,
  double? height,
  double topPadding = 0,
}) {
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
