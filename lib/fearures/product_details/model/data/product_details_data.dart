import 'package:dio/dio.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../../../home/model/models/products_model.dart';

class ProductDetailsData {
  final Dio dio;

  ProductDetailsData(this.dio);

  Future<List<ProductVariation>> getProductVariations(int productId) async {
    final url = '${ApiEndpoints.baseUrl}/$productId/variations';
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'consumer_key': ApiEndpoints.consumerKey,
          'consumer_secret': ApiEndpoints.consumerSecret,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<ProductVariation> variations =
            data.map((json) => ProductVariation.fromJson(json)).toList();
        return variations;
      } else {
        throw Exception('Failed to load variations');
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
