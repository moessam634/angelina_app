import 'package:angelinashop/fearures/home/model/models/products_model.dart';

sealed class ProductsState {}

final class ProductLoadingState extends ProductsState {}

final class ProductSuccessState extends ProductsState {
  final List<ProductsModel> products;

  ProductSuccessState({required this.products});
}
final class ProductLoadingMoreState extends ProductSuccessState {
  ProductLoadingMoreState({required super.products});
}
final class ProductFailureState extends ProductsState {
  final String errorMessage;

  ProductFailureState({required this.errorMessage});
}
