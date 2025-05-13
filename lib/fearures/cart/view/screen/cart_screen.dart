import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:angelinashop/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../switcher/cubit/switcher_cubit.dart';
import '../widget/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: defaultAppBar(
            context: context,
            height: 100.h,
            title: Text("عربه التسوق", style: TextStyles.k24),
            actions: [
              IconButton(
                  onPressed: () {
                    final nav = Navigator.of(context);
                    if (nav.canPop()) {
                      nav.pop();
                    } else {
                      sl<SwitcherCubit>().changeScreen(0);
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 20.sp))
            ],
          ),
          body: CartBody()),
    );
  }
}
