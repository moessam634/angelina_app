import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:angelinashop/core/utils/price_utils.dart';
import 'package:angelinashop/fearures/home/home_cubit/categories_cubit/categories_cubit.dart';
import 'package:angelinashop/fearures/home/home_cubit/categories_cubit/categories_state.dart';
import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_cubit.dart';
import 'package:angelinashop/fearures/home/view/screen/all_products_screen.dart';
import 'package:angelinashop/fearures/home/view/widgets/custom_product_card.dart';
import 'package:angelinashop/fearures/product_details/view/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../favorite/cubit/favorite_cubit.dart';
import '../../home_cubit/products_cubit/product_state.dart';
import 'custom_carousel_slider.dart';
import 'custom_category_item.dart';
import 'custom_category_row.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
    context.read<ProductsCubit>().getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCarousel(
                imageUrls: [
                  'https://i.imgur.com/OnwEDW3.jpg',
                  'https://farm3.staticflickr.com/2220/1572613671_7311098b76_z_d.jpg',
                  'https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg',
                  'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg',
                ],
              ),
              SizedBox(height: 8.h),
              CustomCategoryRow(
                  title: "الاقسام",
                  more: 'المزيد',
                  titleStyle:
                      TextStyles.k16.copyWith(fontWeight: FontWeight.w700),
                  onPressed: () {}),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesSuccessState) {
                    final categories = state.data;
                    return SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCategoryItem(
                            image: categories[index].image ??ImageApp.categoryImage,
                            categoryName: categories[index].name ?? "No Name",
                            onTap: () {
                              context
                                  .read<ProductsCubit>()
                                  .getProduct(categoryId: categories[index].id);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 15.w);
                        },
                      ),
                    );
                  } else if (state is CategoriesErrorState) {
                    return Text(
                      'Error loading categories:',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return const CategoryListShimmer();
                  }
                },
              ),
              CustomCategoryRow(
                title: 'احدث المنتجات',
                more: 'المزيد',
                titleStyle:
                    TextStyles.k16.copyWith(fontWeight: FontWeight.w700),
                onPressed: () {
                  NavigationHelper.push(
                      context: context, destination: AllProductsScreen());
                },
              ),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const ProductGridShimmer();
                  } else if (state is ProductSuccessState) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Text(
                            'لا توجد منتجات متاحة حالياً',
                            style: TextStyles.k16
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 350.h,
                        crossAxisSpacing: 14.w,
                        mainAxisSpacing: 12.h,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final isFav = context
                            .read<FavoriteCubit>()
                            .isFavorite(product.id!);
                        final isDiscounted = PriceUtils.isTrulyDiscounted(
                          price: product.price ?? '0',
                          regularPrice: product.regularPrice ?? '0',
                          salePrice: product.salePrice ?? '0',
                          onSale: product.onSale ?? false,
                        );

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.w),
                          child: CustomProductCard(
                            imageUrl: product.images?.first.src ?? "",
                            title: product.name ?? "No Name",
                            price: product.price ?? "0.0",
                            oldPrice: product.regularPrice ?? "0.0",
                            subtitle: product.categories?.first.name ?? "No Name",
                            isDiscounted: isDiscounted,
                            discountLabel: isDiscounted
                                ? '${PriceUtils.calculateDiscountPercentage(product.price ?? '0', product.regularPrice ?? '0')}%'
                                : null,
                            onIconPressed: () {
                              context
                                  .read<FavoriteCubit>()
                                  .toggleFavorite(product);
                              setState(() {});
                            },
                            icon: isFav
                                ? ImageApp.filledHeartIcon
                                : ImageApp.heartIcon,
                            onTap: () {
                              NavigationHelper.push(
                                context: context,
                                destination: ProductDetailsScreen(
                                  model: product,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is ProductFailureState) {
                    return Center(
                      child: Text(
                          'حدث خطأ أثناء تحميل المنتجات: ${state.errorMessage}',
                          style: TextStyle(color: Colors.red)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
