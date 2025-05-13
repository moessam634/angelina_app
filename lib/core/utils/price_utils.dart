class PriceUtils {
  static bool isTrulyDiscounted(
      {String? price, String? regularPrice, String? salePrice, bool? onSale}) {
    final double current = double.tryParse(price!) ?? 0;
    final double original = double.tryParse(regularPrice!) ?? 0;

    if (!onSale!) return false;

    final bool priceLooksDiscounted = original > 0 && current < original;
    return priceLooksDiscounted;
  }

  static int calculateDiscountPercentage(String price, String regularPrice) {
    final double current = double.tryParse(price) ?? 0;
    final double original = double.tryParse(regularPrice) ?? 0;

    if (original <= 0 || current >= original) return 0;
    final discount = ((original - current) / original) * 100;
    return discount.round();
  }
}
