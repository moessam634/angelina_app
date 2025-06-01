import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_cubit.dart';
import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/helper/navigation_helper.dart';
import '../../../../core/styles/image_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../favorite/cubit/favorite_cubit.dart';
import '../../../product_details/view/screen/product_details_screen.dart';
import 'custom_product_card.dart';

class AllProductsBody extends StatefulWidget {
  const AllProductsBody({super.key});

  @override
  State<AllProductsBody> createState() => _AllProductsBodyState();
}

class _AllProductsBodyState extends State<AllProductsBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final cubit = context.read<ProductsCubit>();
    super.initState();
    // Load products when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getProduct();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          cubit.hasMore &&
          cubit.state is! ProductLoadingState) {}
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: const ProductGridShimmer(),
          );
        } else if (state is ProductFailureState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Text(
                state.errorMessage,
                style: TextStyles.k16.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          );
        } else if (state is ProductSuccessState) {
          final products = state.products;
          final cubit = context.read<ProductsCubit>();
          final isLoadingMore = state is ProductLoadingMoreState;

          return ListView(controller: _scrollController, children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(children: [
                  if (products.isEmpty)
                    Center(
                      child: Text(
                        'لا توجد منتجات متاحة حالياً',
                        style: TextStyles.k16
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    )
                  else
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 350.h,
                        crossAxisSpacing: 14.w,
                        mainAxisSpacing: 12.h,
                      ),
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
                                destination:
                                    ProductDetailsScreen(model: product),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 20.h),
                  if (cubit.hasMore)
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        child: CustomButton(
                            verticalPadding: 16.h,
                            onTap: isLoadingMore
                                ? null
                                : () {
                                    context
                                        .read<ProductsCubit>()
                                        .loadMoreProducts();
                                  },
                            style: TextStyles.k16.copyWith(color: Colors.white),
                            child: isLoadingMore
                                ? Center(
                                    child: SpinKitFadingCircle(
                                        size: 24.sp, color: Colors.white))
                                : Text(
                                    "عرض المزيد",
                                    textAlign: TextAlign.center,
                                    style: TextStyles.k16
                                        .copyWith(color: Colors.white),
                                  ))),
                ]))
          ]);
        }
        return SizedBox.shrink();
      },
    );
  }
}
