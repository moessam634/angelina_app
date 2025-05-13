import 'dart:async';
import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/navigation_helper.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/image_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../favorite/cubit/favorite_cubit.dart';
import '../../../home/home_cubit/products_cubit/product_cubit.dart';
import '../../../home/view/widgets/custom_product_card.dart';
import '../../../product_details/view/screen/product_details_screen.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = controller.text.trim();
      if (query.isNotEmpty) {
        context.read<ProductsCubit>().searchProducts(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller,
                hintText: "بحث",
                hintStyle: TextStyles.k16.copyWith(
                    color: ColorsApp.kLightGreyColor,
                    fontWeight: FontWeight.w400),
                radius: 8.r,
                fillColor: Colors.white,
                focusedFillColor: Colors.blueGrey.shade50,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.search, color: ColorsApp.kThirdColor),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    context.read<ProductsCubit>().searchProducts(query);
                  }
                },
              ),
              SizedBox(height: 30.h),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (controller.text.isEmpty) {
                    return SizedBox(
                      height: .5.sh,
                      child: Center(
                        child: Text("ابحث عن اسم المنتج",
                            style: TextStyles.k22
                                .copyWith(color: ColorsApp.kPrimaryColor)),
                      ),
                    );
                  } else if (state is ProductLoadingState) {
                    return const ProductGridShimmer();
                  } else if (state is ProductFailureState) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is ProductSuccessState) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return SizedBox(
                          height: .5.sh,
                          child: Center(
                              child: Text("لا يوجد منتج بهذا الاسم",
                                  style: TextStyles.k22.copyWith(
                                      color: ColorsApp.kPrimaryColor))));
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 350.h,
                            crossAxisSpacing: 14.w,
                            mainAxisSpacing: 12.h),
                        itemCount: products.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final isFav = context
                              .read<FavoriteCubit>()
                              .isFavorite(product.id!);
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.w),
                              child: CustomProductCard(
                                  icon: isFav
                                      ? ImageApp.filledHeartIcon
                                      : ImageApp.heartIcon,
                                  onIconPressed: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(product);
                                    setState(() {});
                                  },
                                  imageUrl: product.images?.first.src ?? "",
                                  title: product.name ?? "No Name",
                                  price: product.price ?? "0.0",
                                  oldPrice: product.regularPrice ?? "0.0",
                                  onTap: () {
                                    NavigationHelper.push(
                                        context: context,
                                        destination: ProductDetailsScreen(
                                            model: product));
                                  }));
                        });
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
