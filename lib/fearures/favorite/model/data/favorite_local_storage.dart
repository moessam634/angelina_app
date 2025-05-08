// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../home/model/models/products_model.dart';
//
// class FavoriteRepository {
//   final String _key = 'favorite_products';
//
//   Future<List<ProductsModel>> fetchFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(_key);
//     if (jsonString == null) return [];
//     return (json.decode(jsonString) as List)
//         .map((e) => ProductsModel.fromMap(e))
//         .toList();
//   }
//
//   Future<void> addFavorite(ProductsModel product) async {
//     final favorites = await fetchFavorites();
//     favorites.add(product);
//     await _save(favorites);
//   }
//
//   Future<void> removeFavorite(int id) async {
//     final favorites = await fetchFavorites();
//     favorites.removeWhere((p) => p.id == id);
//     await _save(favorites);
//   }
//
//   Future<void> _save(List<ProductsModel> products) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = json.encode(products.map((e) => e.toMap()).toList());
//     await prefs.setString(_key, jsonString);
//   }
//
//   Future<List<ProductsModel>> searchFavorites(String query) async {
//     final all = await fetchFavorites();
//     return all
//         .where((p) =>
//         (p.name ?? '').toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
