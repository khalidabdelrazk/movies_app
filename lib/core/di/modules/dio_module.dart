import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/api%20manager/api_endpoints.dart';
import 'package:movies/core/di/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModules {
  @lazySingleton
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    dio.options.baseUrl = ApiEndpoints.moviesBaseUrl;
    dio.interceptors.add(getIt<PrettyDioLogger>());
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }
}
