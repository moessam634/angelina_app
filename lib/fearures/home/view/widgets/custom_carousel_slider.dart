import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_carousel_indicator.dart';
import 'custom_stack_carosel_slyder_item.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const CustomCarousel({super.key, required this.imageUrls});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int currentIndex = 0;

  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            height: 180.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) => setState(() {
              currentIndex = index;
            }),
          ),
          items: widget.imageUrls.map((url) {
            return CustomStackCarouselSlyderItem(
              image: url,
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        CustomCarouselIndicator(
          itemCount: widget.imageUrls.length,
          currentIndex: currentIndex,
          onDotTap: (index) => controller.animateToPage(index),
        ),
      ],
    );
  }
}
