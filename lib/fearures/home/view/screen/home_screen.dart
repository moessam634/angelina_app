import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/fearures/home/home_cubit/categories_cubit/categories_cubit.dart';
import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_cubit.dart';
import 'package:angelinashop/fearures/home/view/widgets/custom_drawer.dart';
import 'package:angelinashop/fearures/search/view/screen/search_screen.dart';
import 'package:angelinashop/fearures/switcher/cubit/switcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: defaultAppBar(
            context: context,
            title: Image.asset(ImageApp.angelinaImage),
            hasDrawer: true,
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationHelper.push(
                        context: context, destination: SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    sl<SwitcherCubit>().changeScreen(2);
                  },
                  icon: Icon(Icons.shopping_cart)),
            ],
            height: 60.h),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<CategoriesCubit>()),
            BlocProvider(create: (context) => sl<ProductsCubit>()),
          ],
          child: HomeScreenBody(),
        ),
      ),
    );
  }
}
