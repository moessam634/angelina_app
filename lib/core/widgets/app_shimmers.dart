import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget shimmerBox({
  double height = 100,
  double width = double.infinity,
  double radius = 10,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    ),
  );
}

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return shimmerBox(height: 180.h, radius: 10);
  }
}


class CategoryListShimmer extends StatelessWidget {
  const CategoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, __) => shimmerBox(height: 120.h, width: 90.w),
        separatorBuilder: (_, __) => SizedBox(width: 15.w),
      ),
    );
  }
}


class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 350.h,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 12.h,
      ),
      itemBuilder: (_, __) => shimmerBox(height: 350.h, radius: 20),
    );
  }
}

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          shimmerBox(height: 0.52.sh), // Image carousel placeholder
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                shimmerBox(height: 25.h, width: 250.w),
                SizedBox(height: 10.h),
                shimmerBox(height: 20.h, width: 150.w),
                SizedBox(height: 10.h),
                shimmerBox(height: 40.h, width: 120.w),
                SizedBox(height: 10.h),
                shimmerBox(height: 20.h, width: 120.w),
                SizedBox(height: 10.h),
                shimmerBox(height: 60.h),
                SizedBox(height: 20.h),
                shimmerBox(height: 40.h, width: 190.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreenShimmer extends StatelessWidget {
  const CartScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          padding: EdgeInsets.only(bottom: 295.h),
          itemCount: 5,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: shimmerBox(height: 120.h, radius: 20),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                shimmerBox(height: 45.h, radius: 8), // Discount field
                SizedBox(height: 15.h),
                shimmerBox(height: 20.h, width: 250.w), // Product price row
                SizedBox(height: 10.h),
                shimmerBox(height: 1.h, width: double.infinity), // Divider
                SizedBox(height: 10.h),
                shimmerBox(height: 20.h, width: 250.w), // Total row
                SizedBox(height: 20.h),
                shimmerBox(height: 50.h, radius: 10), // Button
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalProductItemShimmer extends StatelessWidget {
  const HorizontalProductItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              height: 100.h,
              width: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(width: 12.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20.h, width: 150.w, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 16.h, width: 100.w, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 20.h, width: 80.w, color: Colors.white),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            // Counter
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 20.h, width: 55.w, color: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CheckoutFormShimmer extends StatelessWidget {
  const CheckoutFormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          shimmerBox(),
          shimmerBox(),
          shimmerBox(),
          shimmerBox(),
          Row(
            children: [
              Expanded(child: shimmerBox()),
              SizedBox(width: 10.w),
              Expanded(child: shimmerBox()),
            ],
          ),
          Row(
            children: [
              Expanded(child: shimmerBox()),
              SizedBox(width: 10.w),
              Expanded(child: shimmerBox()),
            ],
          ),
          Row(
            children: [
              Expanded(child: shimmerBox()),
              SizedBox(width: 10.w),
              Expanded(child: shimmerBox()),
            ],
          ),
          shimmerBox(height: 50),
        ],
      ),
    );
  }
}

class PaymentShimmer extends StatelessWidget {
  const PaymentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
