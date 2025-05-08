import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final Function(int index)? onPageChanged;

  const CustomCarousel(
      {super.key,
      required this.items,
      this.height = 200,
      this.autoPlay = true,
      this.enlargeCenterPage = true,
      this.autoPlayInterval = const Duration(seconds: 3),
      this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
      this.autoPlayCurve = Curves.fastOutSlowIn,
      this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: enlargeCenterPage,
        autoPlayInterval: autoPlayInterval,
        autoPlayAnimationDuration: autoPlayAnimationDuration,
        autoPlayCurve: autoPlayCurve,
        onPageChanged: (index, reason) {
          if (onPageChanged != null) onPageChanged!(index);
        },
      ),
    );
  }
}
