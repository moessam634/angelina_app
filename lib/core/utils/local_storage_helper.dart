import 'dart:convert';
import 'package:angelinashop/fearures/home/model/models/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fearures/cart/model/model/cart_model.dart';


class LocalStorageService {
  static const String _cartKey = 'cart_items';
  static const String _favKey = 'fav_items';

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
}
