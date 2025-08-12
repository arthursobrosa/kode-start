import 'package:dio/dio.dart';

abstract class ApiService {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  static Future<T> fetchEntity<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    int? page,
    (String, dynamic)? property,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};

      if (page != null) {
        queryParameters['page'] = page;
      }

      if (property != null) {
        queryParameters[property.$1] = property.$2;
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return fromJson(response.data);
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        switch (dioError.response!.statusCode) {
          case 404:
            throw ApiException('Entity not found', statusCode: 404);
          case 500:
            throw ApiException('Internal server error.', statusCode: 500);
          default:
            throw ApiException(
              'Unknown error: ${dioError.response!.statusCode}',
              statusCode: dioError.response!.statusCode,
            );
        }
      } else {
        throw ApiException('Connection error: ${dioError.message}');
      }
    } catch (error) {
      throw ApiException('Unexpected error: $error');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}
