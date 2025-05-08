import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:angelinashop/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: defaultAppBar(
            context: context,
            height: 100.h,
            title: Text("عربه التسوق", style: TextStyles.k24),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new, size: 20.sp))),
        body: CartBody());
  }
}
