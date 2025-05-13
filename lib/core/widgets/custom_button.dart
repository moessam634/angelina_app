// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../styles/colors_app.dart';
//
// class CustomButton extends StatelessWidget {
//   const CustomButton(
//       {super.key,
//       required this.text,
//       this.style,
//       this.onTap,
//       this.color,
//       this.border,
//       this.radius,
//       this.width,
//       this.height,
//       this.verticalPadding,
//       this.horizontalPadding,this.isDisabled});
//
//   final String text;
//   final TextStyle? style;
//   final Color? color;
//   final BoxBorder? border;
//   final void Function()? onTap;
//   final double? radius;
//   final double? width, height;
//   final double? verticalPadding, horizontalPadding;
//   final bool? isDisabled;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: width ?? double.infinity,
//         height: height,
//         padding: EdgeInsets.symmetric(
//             vertical: verticalPadding ?? 16.h,
//             horizontal: horizontalPadding ?? 0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(radius ?? 16.r),
//           border: border ?? Border.all(color: ColorsApp.kPrimaryColor),
//           color: color ?? ColorsApp.kPrimaryColor,
//         ),
//         child: Text(
//           text,
//           style: style,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors_app.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.style,
    this.onTap,
    this.color,
    this.border,
    this.radius,
    this.width,
    this.height,
    this.verticalPadding,
    this.horizontalPadding,
    this.disabled = false,
  });

  final String text;
  final TextStyle? style;
  final Color? color;
  final BoxBorder? border;
  final void Function()? onTap;
  final double? radius;
  final double? width, height;
  final double? verticalPadding, horizontalPadding;
  final bool disabled; // Default to false

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 16.h,
          horizontal: horizontalPadding ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 16.r),
          border: border ?? Border.all(
            color: disabled
                ? ColorsApp.kLightGreyColor // Use gray for disabled state
                : ColorsApp.kPrimaryColor,
          ),
          color: disabled
              ? Colors.grey.shade300 // Use a lighter color when disabled
              : color ?? ColorsApp.kPrimaryColor,
        ),
        child: Text(
          text,
          style: disabled
              ? (style?.copyWith(color: Colors.grey.shade700) ??
              TextStyle(color: Colors.grey.shade700))
              : style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}