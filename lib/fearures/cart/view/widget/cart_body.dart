import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/core/utils/enums.dart';
import 'package:angelinashop/core/widgets/custom_button.dart';
import 'package:angelinashop/fearures/check_out/view/screen/check_out_screen.dart';
import 'package:angelinashop/fearures/favorite/cubit/favorite_cubit.dart';
import 'package:angelinashop/fearures/product_details/view/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_counter_container.dart';
import '../../../../core/widgets/custom_horizontal_product_item.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_state.dart';
import 'custom_check_out_container.dart';
import 'custom_row_text.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  final ScrollController scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    context.read<CartCubit>().loadCart();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible) setState(() => isVisible = false);
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isVisible) setState(() => isVisible = true);
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isVisible) setState(() => isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is CartLoading) {
        return const CartScreenShimmer();
      } else if (state is CartLoaded) {
        final cartItems = state.items;
        final totalCartPrice = context.read<CartCubit>().total;
        if (cartItems.isEmpty) {
          return Center(
              child: Text("عربه التسوق فارغه",
                  style:
                      TextStyles.k22.copyWith(color: ColorsApp.kPrimaryColor)));
        }
        return Stack(
          children: [
            ListView.separated(
              controller: scrollController,
              itemCount: cartItems.length,
              padding: EdgeInsets.only(bottom: 295.h),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final product = item.product;
                final isFav =
                    context.read<FavoriteCubit>().isFavorite(product.id!);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomHorizontalProductItem(
                    productCardType: ProductCardType.cart,
                    textDirection: TextDirection.ltr,
                    onDelete: () {
                      context.read<CartCubit>().removeItem(product.id!);
                    },
                    onTap: () {
                      NavigationHelper.push(
                          context: context,
                          destination: ProductDetailsScreen(model: product));
                    },
                    title: product.name ?? '',
                    price: '${item.totalPrice.toStringAsFixed(2)} ر.س',
                    image: product.images?.first.src ?? '',
                    rate: product.ratingCount?.toString() ?? "0",
                    description: product.shortDescription ?? '',
                    onPressed: (_) {},
                    onFavPressed: () {
                      context.read<FavoriteCubit>().toggleFavorite(product);
                      setState(() {});
                    },
                    iconColor:
                        isFav ? ImageApp.filledHeartIcon : ImageApp.heartIcon,
                    productCartPriceSection: CustomCounterContainer(
                      width: 55.w,
                      height: 20.h,
                      style: TextStyles.k16.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                      iconSize: 12.sp,
                      text: item.quantity.toString(),
                      onPressedPlus: () {
                        context
                            .read<CartCubit>()
                            .updateQuantity(product.id!, item.quantity + 1);
                      },
                      onPressedMinus: () {
                        if (item.quantity > 1) {
                          context
                              .read<CartCubit>()
                              .updateQuantity(product.id!, item.quantity - 1);
                        } else {
                          context.read<CartCubit>().removeItem(product.id!);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 360),
              curve: Curves.easeInOut,
              bottom: isVisible ? 0.h : -.38.sh,
              left: 0,
              right: 0,
              child: CustomCheckOutContainer(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: "كود الخصم",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15.h),
                      CustomRowText(
                        text1: 'سعر المنتجات',
                        text2: '${totalCartPrice.toStringAsFixed(2)} ر.س',
                        text1Style: TextStyles.k16,
                        text2Style: TextStyles.k18,
                      ),
                      SizedBox(height: 10.h),
                      // CustomRowText(
                      //   text1: 'خصم:',
                      //   text2: r"$5",
                      //   text1Style: TextStyles.k16,
                      //   text2Style: TextStyles.k18,
                      // ),
                      SizedBox(height: 10.h),
                      Divider(
                        color: ColorsApp.kBlackColor,
                        thickness: .7,
                      ),
                      SizedBox(height: 10.h),
                      CustomRowText(
                        text1: 'المجموع',
                        text2: '${totalCartPrice.toStringAsFixed(2)} ر.س',
                        text1Style: TextStyles.k16,
                        text2Style: TextStyles.k18,
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        text: 'اتمام الطلب',
                        verticalPadding: 10.h,
                        radius: 10.r,
                        style: TextStyles.k16.copyWith(color: Colors.white),
                        onTap: () {
                          NavigationHelper.push(
                              context: context, destination: CheckOutScreen());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: Text("Cart is empty"));
      }
    }));
  }
}
