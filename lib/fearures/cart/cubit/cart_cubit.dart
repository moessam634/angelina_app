import 'package:angelinashop/core/utils/local_storage_helper.dart';
import 'package:bloc/bloc.dart';
import '../model/model/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + item.totalPrice);

  Future<void> loadCart() async {
    emit(CartLoading());
    _items = await LocalStorageService.loadCartItems();
    emit(CartLoaded(_items));
  }

  Future<void> addItem(CartItemModel newItem) async {
    final index =
        _items.indexWhere((item) => item.product.id == newItem.product.id);
    if (index >= 0) {
      _items[index].quantity += newItem.quantity;
    } else {
      _items.add(newItem);
    }
    await LocalStorageService.saveCartItems(_items);
    emit(CartLoaded(_items));
  }

  Future<void> removeItem(int productId) async {
    _items.removeWhere((item) => item.product.id == productId);
    await LocalStorageService.saveCartItems(_items);
    emit(CartLoaded(_items));
  }

  Future<void> clearCart() async {
    _items.clear();
    await LocalStorageService.clearCart();
    emit(CartLoaded(_items));
  }

  Future<void> updateQuantity(int productId, int newQty) async {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = newQty;
      await LocalStorageService.saveCartItems(_items);
      emit(CartLoaded(_items));
    }
  }
}
