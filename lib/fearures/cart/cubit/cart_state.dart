import 'package:angelinashop/fearures/cart/model/model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  CartLoaded(this.items);
}
