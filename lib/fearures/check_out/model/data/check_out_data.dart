import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:angelinashop/core/networking/api_endpoints.dart';
import '../models/orders_model.dart';

class OrdersData {
  final Dio dio;

  OrdersData(this.dio);

  Future<Response> createOrder({required OrdersModel order}) async {
    try {
      final String basicAuth = 'Basic ${base64.encode(
        utf8.encode('${ApiEndpoints.userName}:${ApiEndpoints.password}'),
      )}';

      final data = order.toJson();
      print("Order Request Body: ${jsonEncode(data)}");
      final response = await dio.post(
        ApiEndpoints.orders,
        options: Options(headers: {'Authorization': basicAuth}),
        data: data,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}
