import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/utils/enums.dart';
import 'package:angelinashop/core/widgets/custom_product_price_section.dart';
import 'package:angelinashop/core/widgets/custom_rating_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/image_app.dart';
import '../styles/text_styles.dart';
import 'custom_cached_network_image.dart';
import 'custom_clickable_icon.dart';
import 'custom_rich_text.dart';

class CustomHorizontalProductItem extends StatelessWidget {
  const CustomHorizontalProductItem(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.rate,
      this.onPressed,
      this.onTap,
      this.description,
      required this.productCardType,
      this.priceTextStyle,
      this.productCartPriceSection,
      this.productFavoritePriceSection,
      this.textDirection,
      this.onDelete,
      this.iconColor,
      this.onFavPressed});

  final String? image, title, price, rate, description, iconColor;
  final Widget? productCartPriceSection, productFavoritePriceSection;
  final TextStyle? priceTextStyle;
  final ProductCardType productCardType;
  final void Function(BuildContext)? onPressed;
  final void Function()? onTap, onDelete, onFavPressed;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: .38.sw,
                  height: .16.sh,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r)),
                      child: CustomCachedNetworkImage(url: image ?? "")),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: CustomClickableIcon(
                      height: 28.sp, icon: iconColor, onPressed: onFavPressed),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    height: .16.sh,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            bottomLeft: Radius.circular(8.r))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(
                          title: title,
                          child: CustomRatingRow(rate: rate),
                        ),
                        SizedBox(height: 4.h),
                        Text(description ?? "",
                            style: TextStyles.k12
                                .copyWith(color: ColorsApp.kThirdColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        // Spacer(),
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomProductPriceSection(
                                type: productCardType,
                                textDirection: textDirection,
                                productCartPriceSection: productCartPriceSection,
                                price: price,
                                priceTextStyle: priceTextStyle,
                                productFavoritePriceSection:
                                    productFavoritePriceSection),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -15.h,
                    left: -15.w,
                    child: CustomClickableIcon(
                        icon: ImageApp.xIcon,
                        height: 50.h,
                        width: 50.w,
                        onPressed: onDelete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
