import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// wrap for Dio, concentrates operations here, because Dio can be replaced
class AppHttpClient {
  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Duration? cache,
    T Function(dynamic data)? parse,
  }) async {
    final dio = Dio();

    if (cache != null) {
      dio.interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: MemCacheStore(),
            maxStale: cache,
          ),
        ),
      );
    }

    late final Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: queryParameters,
      );
    } on DioError catch (e) {
      throw HttpRequestError(e.message, e.response?.statusCode);
    }

    return parse?.call(response.data) ?? response.data;
  }
}

class HttpRequestError {
  final String message;
  final int? code;

  HttpRequestError(this.message, this.code);
}
