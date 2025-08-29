import 'package:dio/dio.dart';
import '../../domain/models/product.dart';

class ProductService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://dummyjson.com';

  Future<ProductListResponse> getProducts({
    int skip = 0,
    int limit = 20,
    String? category,
    String? search,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {'skip': skip, 'limit': limit};

      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      if (search != null && search.isNotEmpty) {
        queryParams['q'] = search;
      }

      final response = await _dio.get(
        '$_baseUrl/products',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ProductListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('$_baseUrl/products/categories');

      if (response.statusCode == 200) {
        final List<dynamic> categories = response.data;
        return categories.cast<String>();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
