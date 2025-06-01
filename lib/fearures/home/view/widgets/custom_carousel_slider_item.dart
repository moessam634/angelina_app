import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselSliderItem extends StatelessWidget {
  const CustomCarouselSliderItem({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(18.r), child:
    Image.asset(image,fit: BoxFit.fill,)

    );
  }
}
// CustomCachedNetworkImage(url: image)
// Image.asset(image,fit: BoxFit.fill,)