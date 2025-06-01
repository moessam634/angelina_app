import 'package:angelinashop/fearures/home/view/widgets/custom_carousel_slider_item.dart';
import 'package:flutter/material.dart';

class CustomStackCarouselSlyderItem extends StatelessWidget {
  const CustomStackCarouselSlyderItem(
      {super.key, required this.image, this.title, this.onTap});

  final String image;
  final String? title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomCarouselSliderItem(image: image),
      // Positioned(
      //   top: 20.h,
      //   left: 90.w,
      //   child: Column(
      //     children: [
      //       Text(
      //         title ?? "No Title",
      //         style: TextStyles.k18.copyWith(color: ColorsApp.kBlackColor),
      //       ),
      //       CustomButton(
      //         text: 'تسوق الان',
      //         style: TextStyles.k10.copyWith(color: Color(0xffC4B399)),
      //         width: .2.sw,
      //         radius: 25.r,
      //         verticalPadding: 8.h,
      //         onTap: onTap,
      //       ),
      //     ],
      //   ),
      // ),
    ]);
  }
}
