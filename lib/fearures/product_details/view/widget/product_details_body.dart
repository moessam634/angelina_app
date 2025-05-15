import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/core/utils/local_storage_helper.dart';
import 'package:angelinashop/core/widgets/custom_rating_row.dart';
import 'package:angelinashop/core/widgets/custom_rich_text.dart';
import 'package:angelinashop/fearures/favorite/cubit/favorite_cubit.dart';
import 'package:angelinashop/fearures/product_details/view/widget/product_details_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/html_parser.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_counter_container.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../cart/model/model/cart_model.dart';
import '../../../home/model/models/products_model.dart';
import '../../cubit/product_details_cubit.dart';
import '../../cubit/product_details_state.dart';
import 'custom_drop_down_menu.dart';
import 'expandable_text.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key, required this.model});

  final ProductsModel model;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int quantity = 1;
  String? selectedColor;
  late PageController _pageController;
  int _currentPage = 0;
  late final String description;
  bool isInCart = false;

  void incrementQuantity() {
    setState(() => quantity++);
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    description = htmlDescriptionToSingleLine(widget.model.description);
    final cubit = context.read<ProductDetailsCubit>();
    cubit.setProductModel(widget.model);
    cubit.getProductDetails(widget.model.id!);
    _checkIfInCart();
  }

  Future<void> _checkIfInCart() async {
    final cartItems = await LocalStorageService.loadCartItems();
    // final selectedColor = context.read<ProductDetailsCubit>().state.selectedColor;
    final exists = cartItems.any((item) =>
        item.product.id == widget.model.id &&
        item.selectedOption == selectedColor);
    setState(() => isInCart = exists);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const ProductDetailsShimmer();
        }
        if (state is ProductDetailsError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is ProductDetailsSuccess) {
          final List<ProductImage> allImages = widget.model.images ?? [];
          return SingleChildScrollView(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 0.52.sh,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              allImages.isEmpty
                                  ? Center(
                                      child: Text(
                                        "لا توجد صور متاحة لهذا اللون",
                                        style: TextStyles.k16.copyWith(
                                          color: ColorsApp.kLightGreyColor,
                                        ),
                                      ),
                                    )
                                  : PageView.builder(
                                      controller: _pageController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      },
                                      itemCount: allImages.length,
                                      itemBuilder: (context, index) {
                                        final imageUrl = allImages[index].src ??
                                            "https://via.placeholder.com/150";
                                        return ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20.r),
                                            bottomRight: Radius.circular(20.r),
                                          ),
                                          child: CustomNetworkImage(
                                              image: imageUrl),
                                        );
                                      },
                                    ),
                              Positioned(
                                bottom: 10.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    allImages.length,
                                    (index) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      width: _currentPage == index ? 16.w : 8.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                        color: _currentPage == index
                                            ? ColorsApp.kPrimaryColor
                                            : ColorsApp.kLightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductDetailsAppBar(
                          onPressed: () {
                            context
                                .read<FavoriteCubit>()
                                .toggleFavorite(widget.model);
                            setState(() {});
                          },
                          imageUrl: context
                                  .read<FavoriteCubit>()
                                  .isFavorite(widget.model.id!)
                              ? ImageApp.filledHeartIcon
                              : ImageApp.heartIcon,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRichText(
                                title: widget.model.name,
                                titleStyle: TextStyles.k22
                                    .copyWith(color: ColorsApp.kPrimaryColor),
                                child: CustomRatingRow(
                                    rate: widget.model.ratingCount.toString(),
                                    textStyle: TextStyles.k16.copyWith(
                                        color: ColorsApp.kPrimaryColor),
                                    iconSize: 16.sp),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomCounterContainer(
                                    text: quantity.toString(),
                                    onPressedPlus: incrementQuantity,
                                    onPressedMinus: decrementQuantity,
                                    style: TextStyles.k16.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorsApp.kLightGreyColor,
                                    ),
                                    iconSize: 16.sp,
                                  ),
                                  Flexible(
                                    child: CustomDropDownButton(
                                        selectedOption: state.selectedColor,
                                        options: state.availableColors,
                                        hint: "تحديد أحد الخيارات",
                                        onChanged: (value) {}),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Text("وصف المنتج",
                                  style: TextStyles.k16.copyWith(
                                      color: ColorsApp.kSecondaryColor)),
                              SizedBox(height: 5.h),
                              ExpandableText(
                                text: description,
                                style: TextStyles.k12
                                    .copyWith(color: ColorsApp.kLightGreyColor),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                          "${(double.parse(widget.model.price!) * quantity).toStringAsFixed(2)} ر.س",
                                          style: TextStyles.k22.copyWith(
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    CustomButton(
                                        text: isInCart
                                            ? "حذف من السلة"
                                            : "اضافة الى السلة",
                                        style: TextStyles.k18
                                            .copyWith(color: Colors.white),
                                        verticalPadding: 10.h,
                                        width: 190.w,
                                        color: isInCart
                                            ? ColorsApp.kLightGreyColor
                                            : ColorsApp.kPrimaryColor,
                                        onTap: () async {
                                          final cartItems =
                                              await LocalStorageService
                                                  .loadCartItems();
                                          final index = cartItems.indexWhere(
                                              (item) =>
                                                  item.product.id ==
                                                      widget.model.id &&
                                                  item.selectedOption ==
                                                      selectedColor);
                                          if (isInCart) {
                                            if (index != -1) {
                                              cartItems.removeAt(index);
                                              await LocalStorageService
                                                  .saveCartItems(cartItems);
                                              setState(() => isInCart = false);
                                            }
                                          } else {
                                            // Add to cart
                                            cartItems.add(CartItemModel(
                                              product: widget.model,
                                              quantity: quantity,
                                              selectedOption: selectedColor,
                                            ));
                                            await LocalStorageService
                                                .saveCartItems(cartItems);
                                            setState(() => isInCart = true);
                                          }
                                        })
                                  ])
                            ]))
                  ])));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// CustomButton(
//   text: "اضافة الى السلة",
//   style:
//   TextStyles.k18.copyWith(color: Colors.white),
//   verticalPadding: 10.h,
//   width: 190.w,
//   onTap: () async {
//     // context.read<CartCubit>().addItem(
//     //    );
//     if (quantity < 1) {
//       customSnackBar(
//           context: context,
//           text: "يجب تحديد الكمية");
//       return;
//     }
//     final cartItems =
//     await LocalStorageService.loadCartItems();
//     final selectedColor = state.selectedColor;
//     final index = cartItems.indexWhere(
//           (item) =>
//       item.product.id == widget.model.id &&
//           item.selectedOption == selectedColor,
//     );
//     if (index != -1) {
//       cartItems[index].quantity += quantity;
//     } else {
//       cartItems.add(CartItemModel(
//         product: widget.model,
//         quantity: quantity,
//         selectedOption: selectedColor,
//       ));
//     }
//     await LocalStorageService.saveCartItems(
//         cartItems);
//     customSnackBar(
//         context: context,
//         text: "تمت الإضافة إلى السلة");
//   },
// ),
