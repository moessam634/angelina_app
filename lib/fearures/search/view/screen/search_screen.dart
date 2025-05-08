import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_cubit.dart';
import 'package:angelinashop/fearures/search/view/widget/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        height: 100.h,
        title: Text("بحث", style: TextStyles.k24),
        leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, size: 18.sp))),
      ),
      body: BlocProvider(
        create: (context) => ProductsCubit(sl()),
        child: SearchBody(),
      ),
    );
  }
}
