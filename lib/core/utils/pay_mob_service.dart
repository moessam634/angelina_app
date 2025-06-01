import 'package:dio/dio.dart';
import 'api_keys.dart';

class PaymobManager {
  final Dio dio;

  PaymobManager(this.dio);

  Future<String> getPaymentKey(double amount, String currency) async {
    try {
      // Convert amount to cents as integer (PayMob requires amount in cents)
      int amountInCents = (amount * 100).round();

      // Get authentication token
      String authenticationToken = await _getAuthenticationToken();

      // Get order ID
      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amountCents: amountInCents,
        currency: currency,
      );

      // Get payment key
      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amountCents: amountInCents,
        currency: currency,
        orderId: orderId,
      );

      return paymentKey;
    } catch (e) {
      throw Exception("PayMob error: ${e.toString()}");
    }
  }

  Future<String> _getAuthenticationToken() async {
    final Response response = await dio.post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {
          "api_key": ApiKeys.payMobApiKey,
        }
    );
    return response.data["token"];
  }

  Future<int> _getOrderId({
    required String authenticationToken,
    required int amountCents,
    required String currency
  }) async {
    final Response response = await dio.post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token": authenticationToken,
          "amount_cents": amountCents, // PayMob expects an integer here
          "currency": currency,
          "delivery_needed": false, // Boolean value instead of string
          "items": [],
        }
    );
    return response.data["id"];
  }

  Future<String> _getPaymentKey({
    required String authenticationToken,
    required int orderId,
    required int amountCents,
    required String currency,
  }) async {
    final Response response = await dio.post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "expiration": 3600,
          "auth_token": authenticationToken,
          "order_id": orderId, // Pass integer directly, not as string
          "integration_id": ApiKeys.payMobIntegrationId, // Your integration ID
          "amount_cents": amountCents, // Integer value
          "currency": currency,
          "billing_data": {
            // Required billing data
            "first_name": "Clifford",
            "last_name": "Nicolas",
            "email": "claudette09@exa.com",
            "phone_number": "+86(8)9135210487",
            // Optional fields set to "NA"
            "apartment": "NA",
            "floor": "NA",
            "street": "NA",
            "building": "NA",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "state": "NA"
          },
        }
    );
    return response.data["token"];
  }
}