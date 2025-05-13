import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/core/utils/enums.dart';
import 'package:angelinashop/core/widgets/custom_clickable_icon.dart';
import 'package:angelinashop/core/widgets/custom_horizontal_product_item.dart';
import 'package:angelinashop/core/widgets/custom_text_form_field.dart';
import 'package:angelinashop/fearures/cart/cubit/cart_cubit.dart';
import 'package:angelinashop/fearures/cart/model/model/cart_model.dart';
import 'package:angelinashop/fearures/favorite/cubit/favorite_cubit.dart';
import 'package:angelinashop/fearures/product_details/view/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../cubit/favorite_state.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({super.key});

  @override
  State<FavoriteBody> createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<FavoriteCubit>().loadFavorites();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
          if (state is FavoriteLoading) {
            return const HorizontalProductItemShimmer();
          } else if (state is FavoriteLoaded) {
            final filtered = state.filteredFavorites;
            final query = state.searchQuery;
            return Column(
              children: [
                CustomTextFormField(
                  controller: _searchController,
                  hintText: "بحث",
                  onChanged: (query) {
                    context.read<FavoriteCubit>().searchFavorites(query);
                  },
                  hintStyle: TextStyles.k16.copyWith(
                    color: ColorsApp.kLightGreyColor,
                    fontWeight: FontWeight.w400,
                  ),
                  radius: 8.r,
                  fillColor: Colors.white,
                  focusedFillColor: Colors.blueGrey.shade50,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.search, color: ColorsApp.kThirdColor),
                ),
                SizedBox(height: 25.h),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            query.isNotEmpty
                                ? "هذا المنتج غير موجود فى المفضله"
                                : "لا توجد عناصر مفضلة",
                            style: TextStyles.k22
                                .copyWith(color: ColorsApp.kPrimaryColor),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            final isFav = context
                                .read<FavoriteCubit>()
                                .isFavorite(item.id!);

                            return CustomHorizontalProductItem(
                              onTap: () {
                                NavigationHelper.push(
                                    context: context,
                                    destination:
                                        ProductDetailsScreen(model: item));
                              },
                              productCardType: ProductCardType.favorite,
                              productFavoritePriceSection: CustomClickableIcon(
                                icon: ImageApp.shoppingCartIcon,
                                color: ColorsApp.kPrimaryColor,
                                iconColor: Colors.white,
                                width: 36.w,
                                height: 36.h,
                                onPressed: () async {
                                  await context.read<CartCubit>().addItem(
                                        CartItemModel(
                                            product: item, quantity: 1),
                                      );
                                  await context
                                      .read<FavoriteCubit>()
                                      .toggleFavorite(item);
                                  customSnackBar(
                                      context: context,
                                      text: "تمت الإضافة إلى السلة");
                                },
                              ),
                              title: item.name ?? '',
                              price: '\$${item.price}',
                              image: item.images?.first.src ?? '',
                              rate: item.ratingCount?.toString() ?? '4.5',
                              onFavPressed: () {
                                context
                                    .read<FavoriteCubit>()
                                    .toggleFavorite(item);
                                setState(() {});
                              },
                              iconColor: isFav
                                  ? ImageApp.filledHeartIcon
                                  : ImageApp.heartIcon,
                              onDelete: () {
                                context
                                    .read<FavoriteCubit>()
                                    .toggleFavorite(item);
                              },
                            );
                          },
                        ),
                ),
                if (filtered.isNotEmpty)
                  CustomButton(
                    text: "اضافه الى السله",
                    verticalPadding: 16.h,
                    onTap: () async {
                      await context.read<FavoriteCubit>().addFavoritesToCart();
                      await context.read<FavoriteCubit>().clearFavorites();
                      customSnackBar(
                          context: context, text: "تمت الإضافة إلى السلة");
                    },
                    style: TextStyles.k16.copyWith(color: Colors.white),
                  )
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
