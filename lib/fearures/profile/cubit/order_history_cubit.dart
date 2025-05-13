import 'package:bloc/bloc.dart';
import '../../../core/utils/local_storage_helper.dart';
import '../model/models/orders_history_model.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  Future<void> loadOrderHistory() async {
    emit(OrderHistoryLoading());
    try {
      final history = await LocalStorageService.loadOrderHistory();
      emit(OrderHistoryLoaded(history));
    } catch (e) {
      emit(OrderHistoryError('Failed to load order history.'));
    }
  }

  Future<void> addOrder(OrdersHistoryModel order) async {
    try {
      await LocalStorageService.saveOrder(order);
      await loadOrderHistory();
    } catch (e) {
      emit(OrderHistoryError('Failed to save order.'));
    }
  }

  Future<void> clearHistory() async {
    try {
      await LocalStorageService.clearOrderHistory();
      emit(OrderHistoryLoaded([]));
    } catch (e) {
      emit(OrderHistoryError('Failed to clear order history.'));
    }
  }
}
