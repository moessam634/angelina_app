import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:angelinashop/core/widgets/custom_button.dart';
import 'package:angelinashop/core/widgets/custom_cached_network_image.dart';
import 'package:angelinashop/core/widgets/custom_clickable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatelessWidget {
  final String title, price, imageUrl;
  final String? subtitle;
  final String? oldPrice, icon;

  // final bool isFavorite;
  final bool isDiscounted;
  final String? discountLabel;
  final void Function()? onTap;
  final void Function()? onIconPressed;

  const CustomProductCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      this.subtitle,
      required this.price,
      this.oldPrice,
      // this.isFavorite = false,
      this.isDiscounted = false,
      this.discountLabel,
      this.onTap,
      this.icon,
      this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CustomCachedNetworkImage(
                      url: imageUrl ?? "",
                      height: 180.h,
                    ),
                  ),
                  Positioned(
                      top: 6.h,
                      left: 6.w,
                      child: CustomClickableIcon(
                        icon: icon ?? ImageApp.heartIcon,
                        height: 36.h,
                        width: 30.w,
                        onPressed: onIconPressed,
                      )),
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: isDiscounted
                        ? CircleAvatar(
                            backgroundColor: ColorsApp.kPrimaryColor,
                            radius: 20.r,
                            child: Text(
                              discountLabel ?? '',
                              style: TextStyles.k12.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                style: TextStyles.k12.copyWith(fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              if (subtitle != null && subtitle!.isNotEmpty)
                Text(
                  subtitle ?? "notitle",
                  style:
                      TextStyles.k10.copyWith(color: ColorsApp.kLightGreyColor),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (oldPrice != null && oldPrice!.isNotEmpty) ...[
                    SizedBox(width: 6.w),
                    Text(
                      oldPrice!,
                      style: TextStyle(
                        fontSize: 10.sp,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      " $priceر.س ",
                      style: TextStyles.k12.copyWith(
                          color: ColorsApp.kPrimaryColor,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Flexible(
                child: CustomButton(
                    text: "تحديد أحد الخيارات",
                    width: 110.w,
                    verticalPadding: 8.h,
                    radius: 25.r,
                    style: TextStyles.k10.copyWith(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
