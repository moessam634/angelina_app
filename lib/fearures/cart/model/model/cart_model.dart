import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../home/model/models/products_model.dart';

class CartItemModel extends Equatable {
  final ProductsModel product;
  int quantity;
  final String? selectedOption;

  CartItemModel(
      {required this.product, required this.quantity, this.selectedOption});

  Map<String, dynamic> toMap() => {
        "product": product.toMap(),
        "quantity": quantity,
        "selectedOption": selectedOption
      };

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "selectedOption": selectedOption
      };

  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
      product: ProductsModel.fromMap(map["product"]),
      quantity: map["quantity"],
      selectedOption: map["selectedOption"]);

  factory CartItemModel.fromJson(Map<String, dynamic> map) => CartItemModel(
      product: ProductsModel.fromMap(map["product"]),
      quantity: map["quantity"],
      selectedOption: map["selectedOption"]);

  static String encodeList(List<CartItemModel> items) =>
      jsonEncode(items.map((item) => item.toMap()).toList());

  static List<CartItemModel> decodeList(String source) =>
      (jsonDecode(source) as List)
          .map((item) => CartItemModel.fromMap(item))
          .toList();

  double get totalPrice {
    final price = double.tryParse(product.price ?? '0') ?? 0;
    return price * quantity;
  }

  @override
  List<Object?> get props => [product, quantity, selectedOption];
}
