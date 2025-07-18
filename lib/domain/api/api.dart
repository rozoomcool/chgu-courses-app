import 'package:eventrecs/domain/model/jwt_payload/jwt_payload.dart';
import 'package:eventrecs/repository/shared/auth_shared_repository.dart';
import 'package:eventrecs/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Dio configureDio(AuthSharedRepository authSharedRepository) {
  final options = BaseOptions(
    baseUrl: 'http://$baseUrl',
    headers: {"Accept": "application/json", "content-type": "application/json"},
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  Dio dio = Dio(options);
  dio.interceptors.add(LogInterceptors());
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      print("::: ${authSharedRepository.getAccessToken()}");
      options.headers["Authorization"] =
          "Bearer ${GetIt.I<AuthSharedRepository>().getAccessToken()}";
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response != null && error.response?.statusCode == 401) {
        try {
          // Get refresh token from repository
          final refreshToken = authSharedRepository.getRefreshToken();

          if (refreshToken.isNotEmpty) {

            debugPrint("|||| START REFRESH");
            // Call refresh token endpoint
            final refreshResponse = await dio.post(
              '$baseUrl/api/v1/auth/refresh',
              data: {'refreshToken': refreshToken},
            );

            debugPrint("|||| ${refreshResponse.statusCode} " + refreshResponse.data.toString());

            final data = JwtPayload.fromJson(refreshResponse.data);

            // Save new tokens
            final newAccessToken = data.access;
            final newRefreshToken = data.refresh;

            authSharedRepository.setTokens(newAccessToken, newRefreshToken);
            authSharedRepository.setId(data.user.id);
            authSharedRepository.setEmail(data.user.email);

            // Update headers with new token
            error.requestOptions.headers["Authorization"] =
                "Bearer $newAccessToken";

            // Retry the original request
            final retryResponse = await dio.request(
              error.requestOptions.uri.toString(),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
            );

            return handler.resolve(retryResponse);
          }
        } catch (refreshError) {
          debugPrint("|||| START REFRESH: ${refreshError}");
          // Handle refresh token failure (e.g., logout user)
          authSharedRepository.clear();
          // Optionally redirect to login
          return handler.next(error);
        }
      }
      return handler.next(error);
    },
  ));

  return dio;
}

class LogInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Accept"] = "application/json";
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} | STATUS: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

class TokensInterceptors extends Interceptor {
  final AuthSharedRepository _authSharedRepository;

  TokensInterceptors(this._authSharedRepository);
//
// @override
// void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//   options.headers["Accept"] = "application/json";
//   options.headers["Authorization"] =
//   "Bearer ${_authSharedRepository.getAccessToken()}";
//
//   super.onRequest(options, handler);
// }

// @override
// Future onError(DioException err, ErrorInterceptorHandler handler) async {
//   if (err.response?.statusCode == 403) {
//     if (err.requestOptions.headers.containsKey("Authorization")) {
//       var options = err.requestOptions;
//       options.headers["Authorization"] =
//       "Bearer ${_authSharedRepository.getAccessToken()}";
//
//       return handler.resolve(await);
//     } else {
//
//     }
//   }
//   super.onError(err, handler);
// }
}
