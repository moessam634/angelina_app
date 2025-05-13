import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../switcher/cubit/switcher_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: .7.sw,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ColorsApp.kPrimaryColor),
            child: Center(
                child: Text("القائمة",
                    style: TextStyles.k16.copyWith(color: Colors.white))),
          ),
          ListTile(
            leading: Icon(Icons.home, color: ColorsApp.kPrimaryColor),
            title: Text("الرئيسية"),
            onTap: () {
              sl<SwitcherCubit>().changeScreen(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: ColorsApp.kPrimaryColor),
            title: Text("المفضلة"),
            onTap: () {
              sl<SwitcherCubit>().changeScreen(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: ColorsApp.kPrimaryColor),
            title: Text("عربة التسوق"),
            onTap: () {
              sl<SwitcherCubit>().changeScreen(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: ColorsApp.kPrimaryColor),
            title: Text("حسابي"),
            onTap: () {
              sl<SwitcherCubit>().changeScreen(3);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
