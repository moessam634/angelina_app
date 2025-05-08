import '../../home/model/models/products_model.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final List<ProductVariation>? variations;
  final List<String> availableColors;
  final ProductVariation? selectedVariation;
  final String? selectedColor;

  ProductDetailsSuccess({
    this.variations,
    required this.availableColors,
    this.selectedVariation,
    this.selectedColor,
  });
}

final class ProductDetailsError extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsError(this.errorMessage);
}

