import 'package:angelinashop/fearures/cart/view/screen/cart_screen.dart';
import 'package:angelinashop/fearures/product_details/view/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/image_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../favorite/view/screen/favorite_screen.dart';
import '../../../home/view/screen/home_screen.dart';
import '../../cubit/switcher_cubit.dart';
import '../../cubit/switcher_state.dart';

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => SwitcherScreenState();
}

Widget _buildIcon(String iconPath, int index, int currentIndex) {
  final color =
      index == currentIndex ? ColorsApp.kPrimaryColor : ColorsApp.kThirdColor;

  return SvgPicture.asset(
    iconPath,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}

class SwitcherScreenState extends State<SwitcherScreen> {
  List<Widget> screens = const [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    // SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwitcherCubit(),
      child: BlocBuilder<SwitcherCubit, SwitcherState>(
        builder: (context, state) {
          SwitcherCubit switcherCubit = BlocProvider.of(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: screens[switcherCubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: switcherCubit.currentIndex,
                onTap: switcherCubit.changeScreen,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                fixedColor: ColorsApp.kPrimaryColor,
                selectedLabelStyle: TextStyles.k10,
                unselectedItemColor: ColorsApp.kThirdColor,
                unselectedLabelStyle: TextStyles.k10,
                items: [
                  BottomNavigationBarItem(
                      icon: _buildIcon(
                          ImageApp.homeIcon, 0, switcherCubit.currentIndex),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: _buildIcon(
                          ImageApp.heartIcon, 1, switcherCubit.currentIndex),
                      label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: _buildIcon(ImageApp.shoppingCartIcon, 2,
                          switcherCubit.currentIndex),
                      label: "Cart"),
                  // BottomNavigationBarItem(
                  //     icon: _buildIcon(
                  //         ImageApp.userIcon, 3, switcherCubit.currentIndex),
                  //     label: "Profile"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
