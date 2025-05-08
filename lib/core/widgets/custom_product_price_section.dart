import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../utils/enums.dart';

class CustomProductPriceSection extends StatelessWidget {
  final ProductCardType type;
  final String? price;
  final TextStyle? priceTextStyle;
  final Widget? productCartPriceSection, productFavoritePriceSection;
  final TextDirection? textDirection;

  const CustomProductPriceSection(
      {super.key,
      required this.type,
      this.price,
      this.productCartPriceSection,
      this.productFavoritePriceSection,
      this.priceTextStyle,
      this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: textDirection,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            child: Text(price ?? "", style: priceTextStyle ?? TextStyles.k14)),
        if (type == ProductCardType.cart) ...[
          Flexible(child: productCartPriceSection ?? SizedBox.shrink())
        ] else if (type == ProductCardType.favorite) ...[
          Flexible(child: productFavoritePriceSection ?? SizedBox.shrink())
        ],
      ],
    );
  }
}
