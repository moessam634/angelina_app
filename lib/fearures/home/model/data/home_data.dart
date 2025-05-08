import 'package:angelinashop/fearures/home/model/models/products_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../models/categories_model.dart';

class HomeData {
  final Dio dio;

  HomeData(this.dio);

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.categories);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => CategoriesModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Please check your API credentials.");
      } else {
        throw Exception("Failed to load categories: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  Future<List<ProductsModel>> getProducts({
    int? categoryId,
    int perPage = 10,
    int page = 1,
    String? searchQuery,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'per_page': perPage,
        'consumer_key': ApiEndpoints.consumerKey,
        'consumer_secret': ApiEndpoints.consumerSecret,
        'page': page
      };
      if (categoryId != null) queryParams['category'] = categoryId;
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['search'] = searchQuery;
      }

      final response =
          await dio.get(ApiEndpoints.baseUrl, queryParameters: queryParams);

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        final List<ProductsModel> products =
            productsJson.map((json) => ProductsModel.fromJson(json)).toList();
        return products;
      } else {
        throw Exception("Failed to retrieve products");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

}

