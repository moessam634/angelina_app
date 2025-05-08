import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/colors_app.dart';

class CustomClickableIcon extends StatelessWidget {
  final void Function()? onPressed;
  final String? icon;
  final double? width, height;
  final Color? color, iconColor;

  const CustomClickableIcon(
      {super.key,
      this.onPressed,
      required this.icon,
      this.width,
      this.height,
      this.color,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 35,
      height: height ?? 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: .3.r,
            blurRadius: 10.r,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          icon ?? "",
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
              iconColor ?? ColorsApp.kPrimaryColor, BlendMode.srcIn,),
        ),
      ),
    );
  }
}
