import 'package:angelinashop/fearures/cart/view/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/image_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../favorite/view/screen/favorite_screen.dart';
import '../../../home/view/screen/home_screen.dart';
import '../../../profile/view/screen/profile_screen.dart';
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
  final PageController _controller = PageController();
  List<Widget> screens = const [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   await sl<NotificationService>().showSimpleNotification(
  //     title: 'Test Notification',
  //     body: 'This is a test from foreground!',
  //   );
  //
  //   await Workmanager().registerPeriodicTask(
  //     "check-stock-sale-task",
  //     notifyTask,
  //     frequency: Duration(hours: 6),
  //     initialDelay: Duration(minutes: 1),
  //     backoffPolicy: BackoffPolicy.exponential,
  //     constraints: Constraints(
  //       networkType: NetworkType.connected, // Optional
  //     ),
  //   );
  //
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SwitcherCubit>(),
      child: BlocBuilder<SwitcherCubit, SwitcherState>(
        builder: (context, state) {
          final switcherCubit = context.read<SwitcherCubit>();
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  switcherCubit.changeScreen(index);
                },
                children: screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: switcherCubit.currentIndex,
                onTap: (index) {
                  _controller.jumpToPage(index);
                  switcherCubit.changeScreen(index);
                },
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
                  BottomNavigationBarItem(
                      icon: _buildIcon(
                          ImageApp.userIcon, 3, switcherCubit.currentIndex),
                      label: "Profile"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
