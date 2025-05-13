import 'dart:convert';
import 'package:angelinashop/fearures/home/model/models/products_model.dart';
import 'package:angelinashop/fearures/profile/model/models/orders_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fearures/cart/model/model/cart_model.dart';


class LocalStorageService {
  static const String _cartKey = 'cart_items';
  static const String _favKey = 'fav_items';
  static const String _orderHistoryKey = 'order_history';
  static const String _userInfoKey = 'user_info';

  // ===== CART METHODS =====

  static Future<void> saveCartItems(List<CartItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, encoded);
  }

  static Future<List<CartItemModel>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => CartItemModel.fromJson(e)).toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // ===== FAVORITES METHODS =====

  static Future<void> saveFavorites(List<ProductsModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(products.map((p) => p.toJson()).toList());
    await prefs.setString(_favKey, encoded);
  }

  static Future<List<ProductsModel>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_favKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => ProductsModel.fromJson(e)).toList();
  }

  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favKey);
  }
//Order History Methods
  static Future<void> saveOrder(OrdersHistoryModel order) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadOrderHistory();

    history.add(order); // Append new order

    final encoded = jsonEncode(history.map((o) => o.toJson()).toList());
    await prefs.setString(_orderHistoryKey, encoded);
  }

  static Future<List<OrdersHistoryModel>> loadOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_orderHistoryKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => OrdersHistoryModel.fromJson(e)).toList();
  }
  static Future<void> clearOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_orderHistoryKey);
  }
  // user info
  static Future<void> saveUserInfo(Map<String, String> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(userInfo);
    await prefs.setString(_userInfoKey, encoded);
  }

  static Future<Map<String, String>> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_userInfoKey);
    if (data == null) return {};
    final decoded = jsonDecode(data);
    return Map<String, String>.from(decoded);
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
  }
}
