import '../../../cart/model/model/cart_model.dart';

class OrdersHistoryModel {
  final String id;
  final DateTime date;
  final List<CartItemModel> items;
  final double totalAmount;

  OrdersHistoryModel({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "items": items.map((e) => e.toJson()).toList(),
    "totalAmount": totalAmount,
  };

  factory OrdersHistoryModel.fromJson(Map<String, dynamic> json) => OrdersHistoryModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    items: (json["items"] as List)
        .map((e) => CartItemModel.fromJson(e))
        .toList(),
    totalAmount: json["totalAmount"],
  );
}
