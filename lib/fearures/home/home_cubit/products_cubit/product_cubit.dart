import 'package:bloc/bloc.dart';
import '../../../../core/utils/notification_service.dart';
import '../../model/data/home_data.dart';
import '../../model/models/products_model.dart';
import 'product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._homeProductData) : super(ProductLoadingState());
  final HomeData _homeProductData;
  final List<ProductsModel> _allProducts = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;


  Future<List<ProductsModel>> getProduct(
      {int? categoryId, String? searchQuery}) async {
    try {
      if (!isClosed) emit(ProductLoadingState());
      final products = await _homeProductData.getProducts(
          categoryId: categoryId, searchQuery: searchQuery);
      for (final product in products) {
        if ((product.stockQuantity ?? 0) < 10) {
          await NotificationService().showNotification(
            id: product.id ?? 0,
            title: 'Low Stock Alert',
            body:
                '${product.name ?? 'Product'} stock is low (${product.stockQuantity ?? 0} left)',
          );
        }
      }
      // Reset pagination when getting new products
      _currentPage = 1;
      _allProducts.clear();
      _allProducts.addAll(products);
      _hasMore = products.length >= 10; // Assuming 10 is your page size
      if (!isClosed) emit(ProductSuccessState(products: products));
      return products;
    } catch (e) {
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
      rethrow;
    }
  }

  Future<void> loadMoreProducts() async {
    if (!_hasMore || state is ProductLoadingMoreState) return;
    try {
      // Emit loading more state with current products
      if (!isClosed) {
        emit(ProductLoadingMoreState(products: List.from(_allProducts)));
      }
      _currentPage++;
      final newProducts =
          await _homeProductData.getProducts(page: _currentPage, perPage: 10);

      if (newProducts.length < 10) _hasMore = false;
      _allProducts.addAll(newProducts);

      if (!isClosed) {
        emit(ProductSuccessState(products: List.from(_allProducts)));
      }
    } catch (e) {
      // Revert page number on error
      _currentPage--;
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      if (!isClosed) emit(ProductLoadingState());
      final products = await _homeProductData.getProducts(searchQuery: query);

      // Reset pagination for search results
      _currentPage = 1;
      _allProducts.clear();
      _allProducts.addAll(products);
      _hasMore = false; // Usually search results don't have pagination

      if (!isClosed) emit(ProductSuccessState(products: products));
    } catch (e) {
      if (!isClosed) emit(ProductFailureState(errorMessage: e.toString()));
    }
  }
  // Helper method to check if currently loading more
  bool get isLoadingMore => state is ProductLoadingMoreState;
}
