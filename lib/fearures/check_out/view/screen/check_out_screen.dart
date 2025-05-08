import 'package:angelinashop/fearures/check_out/cubit/check_out_cubit.dart';
import 'package:angelinashop/fearures/check_out/view/widget/check_out_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../cubit/pay_mob_cubit/pay_mob__cubit.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: defaultAppBar(
        context: context,
        height: 100.h,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18.sp,
            ),
          ),
        ),
        title: Text("بيانات الشحن", style: TextStyles.k24),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PayMobCubit(sl())),
          BlocProvider(create: (context) => CheckOutCubit( sl())),
        ],
        child: CheckOutBody(),
      ),
    );
  }
}
