import '../../fearures/home/model/models/products_model.dart';

extension DiscountExtensions on ProductsModel {
  bool get isDiscounted {
    final double current = double.tryParse(price ?? '') ?? 0;
    final double original = double.tryParse(regularPrice ?? '') ?? 0;
    final bool isOnSaleFlag = onSale ?? false;

    if (!isOnSaleFlag) return false;
    return original > 0 && current < original;
  }

  int get discountPercentage {
    final double current = double.tryParse(price ?? '') ?? 0;
    final double original = double.tryParse(regularPrice ?? '') ?? 0;

    if (original <= 0 || current >= original) return 0;
    return ((original - current) / original * 100).round();
  }
}
