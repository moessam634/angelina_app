import 'package:bloc/bloc.dart';
import '../../../core/utils/local_storage_helper.dart';
import '../../cart/model/model/cart_model.dart';
import '../../home/model/models/products_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<ProductsModel> _allFavorites = [];

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    _allFavorites = await LocalStorageService.loadFavorites();
    emit(FavoriteLoaded(
        allFavorites: _allFavorites, filteredFavorites: _allFavorites));
  }

  Future<void> toggleFavorite(ProductsModel product) async {
    final exists = _allFavorites.any((item) => item.id == product.id);
    if (exists) {
      _allFavorites.removeWhere((item) => item.id == product.id);
    } else {
      _allFavorites.add(product);
    }
    await LocalStorageService.saveFavorites(_allFavorites);
    emit(FavoriteLoaded(
      allFavorites: _allFavorites,
      filteredFavorites: _allFavorites,
    ));
  }

  bool isFavorite(int productId) {
    return _allFavorites.any((item) => item.id == productId);
  }

  Future<void> clearFavorites() async {
    _allFavorites.clear();
    await LocalStorageService.clearFavorites();
    emit(FavoriteLoaded(allFavorites: [], filteredFavorites: []));
  }

  void searchFavorites(String query) {
    final results = _allFavorites.where((item) {
      final name = item.name?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    emit(FavoriteLoaded(
        allFavorites: _allFavorites,
        filteredFavorites: results,
        searchQuery: query));
  }

  Future<void> addFavoritesToCart() async {
    final currentCart = await LocalStorageService.loadCartItems();
    for (var fav in _allFavorites) {
      final alreadyInCart =
          currentCart.any((item) => item.product.id == fav.id);
      if (!alreadyInCart) {
        currentCart.add(CartItemModel(product: fav, quantity: 1));
      }
    }
    await LocalStorageService.saveCartItems(currentCart);
  }
}
