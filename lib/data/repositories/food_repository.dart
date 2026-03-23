import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/food_model.dart';
import '../../core/constants/api_constants.dart';

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
      LogInterceptor(
        request: true,
        responseBody: false,
        error: true,
      ),
    );
  }

  Future<List<FoodModel>> fetchFoods(String category) async {
    try {
      final response = await _dio.get('/$category');
      final List<dynamic> items = _extractList(response.data, category);

      debugPrint('✅ Fetched ${items.length} items from /$category');

      return items
          .map((json) => FoodModel.fromJson(json as Map<String, dynamic>))
          .toList();

    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.type} - ${e.message}');
      throw _handleError(e);
    } catch (e) {
      debugPrint('❌ Error: $e');
      rethrow;
    }
  }

  List<dynamic> _extractList(dynamic data, String category) {
    // ✅ Case 1: direct list — /burgers, /pizzas, etc.
    if (data is List) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      // ✅ Case 2: /all → { "bbqs": [...], "burgers": [...], ... }
      // flatten ALL category lists into one
      if (category == 'all') {
        final List<dynamic> all = [];
        for (final value in data.values) {
          if (value is List) all.addAll(value);
        }
        return all;
      }

      // ✅ Case 3: { "burgers": [...] } — category key matches
      if (data.containsKey(category)) {
        return data[category] as List<dynamic>;
      }

      // ✅ Case 4: { "data": [...] }
      if (data.containsKey('data') && data['data'] is List) {
        return data['data'] as List<dynamic>;
      }

      // ✅ Case 5: single object — wrap in list
      return [data];
    }

    return [];
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