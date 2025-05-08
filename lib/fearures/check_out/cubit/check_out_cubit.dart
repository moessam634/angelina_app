// import 'package:bloc/bloc.dart';
// import '../model/data/check_out_data.dart';
// import '../model/models/orders_model.dart';
// import 'check_out_state.dart';
//
// class CheckOutCubit extends Cubit<CheckOutState> {
//   final OrdersData repo;
//
//   CheckOutCubit(this.repo) : super(CheckOutInitial());
//
//   Future<void> submitOrder(OrdersModel order) async {
//     emit(CheckOutLoading());
//     try {
//       final response = await repo.createOrder(order: order);
//       emit(CheckOutSuccess(response));
//     } catch (e) {
//       emit(CheckOutError(e.toString()));
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/data/check_out_data.dart';
import '../model/models/orders_model.dart';
import 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  final OrdersData repo;

  CheckOutCubit( this.repo) : super(CheckOutInitial());

  Future<void> submitOrder(OrdersModel order) async {
    try {
      // Check if the cubit is closed before emitting any states
      if (isClosed) {
        debugPrint("Warning: Attempted to submit order after CheckOutCubit was closed");
        return;
      }
      emit(CheckOutLoading());
      final response = await repo.createOrder(order: order);
      // Double check again to ensure cubit isn't closed
      if (isClosed) return;
      emit(CheckOutSuccess(response));
    } on DioException catch (e) {
      print("Dio error status: ${e.response?.statusCode}");
      print("Dio error body: ${e.response?.data}");
      throw Exception('Failed to create order: ${e.response?.data}');
    }
    catch (e) {
      if (isClosed) return;
      emit(CheckOutError(e.toString()));
    }
  }
}