import 'package:bloc/bloc.dart';
import '../../../../core/utils/notification_service.dart';
import '../../model/data/home_data.dart';
import '../../model/models/products_model.dart';
import 'product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._homeProductData) : super(ProductLoadingState());
  final HomeData _homeProductData;

  Future<List<ProductsModel>> getProduct({
    int? categoryId,
    String? searchQuery,
  }) async {
    try {
      if (!isClosed) emit(ProductLoadingState());

      final products = await _homeProductData.getProducts(
        categoryId: categoryId,
        searchQuery: searchQuery,
      );
      for (final product in products) {
        if ((product.stockQuantity ?? 0) < 900) {
          await NotificationService().showNotification(
            id: product.id ?? 0,
            title: 'Low Stock Alert',
            body:
                '${product.name ?? 'Product'} stock is low (${product.stockQuantity ?? 0} left)',
          );
        }
      }

      if (!isClosed) emit(ProductSuccessState(products: products));
      return products;
    } catch (e) {
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
      rethrow;
    }
  }

  int _currentPage = 1;
  final List<ProductsModel> _allProducts = [];
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  Future<void> loadMoreProducts() async {
    if (!_hasMore) return;
    try {
      final newProducts =
          await _homeProductData.getProducts(page: _currentPage, perPage: 10);
      if (newProducts.length < 10) _hasMore = false;

      _allProducts.addAll(newProducts);
      _currentPage++;
      if (!isClosed) {
        emit(ProductSuccessState(products: List.from(_allProducts)));
      }
    } catch (e) {
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      if (!isClosed) emit(ProductLoadingState());
      final products = await _homeProductData.getProducts(searchQuery: query);
      if (!isClosed) emit(ProductSuccessState(products: products));
    } catch (e) {
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
    }
  }
}

