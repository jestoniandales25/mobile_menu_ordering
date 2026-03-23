import 'package:dio/dio.dart';
import 'package:mobile_menu_ordering/core/constant/api_constants.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';


class FoodRepository {
  late final Dio _dio;

  FoodRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(request: true, responseBody: false, error: true),
    );
  }

  Future<List<FoodModel>> fetchFoods(String category) async {
    try {
      final response = await _dio.get('/$category');
      return (response.data as List)
          .map((json) => FoodModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timed out.');
      case DioExceptionType.receiveTimeout:
        return Exception('Server took too long to respond.');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.connectionError:
        return Exception('No internet connection.');
      default:
        return Exception('Something went wrong: ${e.message}');
    }
  }
}