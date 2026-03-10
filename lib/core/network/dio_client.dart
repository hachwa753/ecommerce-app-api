import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: "https://dummyjson.com",
              connectTimeout: Duration(seconds: 20),
              receiveTimeout: Duration(seconds: 20),
              responseType: ResponseType.json,
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    );
  }
  Dio get client => _dio;
}
