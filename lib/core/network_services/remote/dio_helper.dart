import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          if (error.response?.statusCode == 401) {
            final success = await _refreshToken();
            if (success) {
              final retryOptions = error.requestOptions;
              retryOptions.headers['Authorization'] = 'Bearer ${await _getToken()}';
              try {
                final response = await dio!.request(
                  retryOptions.path,
                  options: Options(
                    method: retryOptions.method,
                    headers: retryOptions.headers,
                  ),
                );
                return handler.resolve(response);
              } catch (e) {
                return handler.reject(e as DioError);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  static Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null) return false;

    try {
      final response = await dio!.post('auth/refresh', data: {
        'refreshToken': refreshToken,
      });

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];
        await prefs.setString('token', newToken);
        await prefs.setString('refreshToken', newRefreshToken);
        return true;
      }
    } catch (e) {
      print('Failed to refresh token: $e');
    }

    return false;
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    return await dio!.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.delete(url, queryParameters: query);
  }
}
