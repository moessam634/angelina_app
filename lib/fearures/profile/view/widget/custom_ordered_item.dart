import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/widgets/custom_cached_network_image.dart';
import 'package:angelinashop/core/widgets/custom_product_price_section.dart';
import 'package:angelinashop/core/widgets/custom_rating_row.dart';
import 'package:angelinashop/core/widgets/custom_rich_text.dart';
import '../../../../core/utils/enums.dart';
import '../../../cart/model/model/cart_model.dart';

class OrderHistoryProductItem extends StatelessWidget {
  final CartItemModel cartItem;

  const OrderHistoryProductItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    return Card(
      elevation: 1.5,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: .38.sw,
            height: .16.sh,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              child: CustomCachedNetworkImage(
                url: product.images?.firstOrNull?.src ?? '',
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: .16.sh,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: TextStyles.k12.copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.shortDescription ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsApp.kThirdColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  CustomProductPriceSection(
                    type: ProductCardType.cart,
                    price: '${product.price}ر.س' ?? '',
                    priceTextStyle: TextStyles.k14,
                    productCartPriceSection: Text('x${cartItem.quantity}',
                        style: TextStyles.k12
                            .copyWith(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
