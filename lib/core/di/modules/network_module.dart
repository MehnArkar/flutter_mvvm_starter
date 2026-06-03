import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_starter/core/di/service_locator.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/core/network/api_endpoints.dart';
import 'package:flutter_mvvm_starter/core/network/interceptors/auth_interceptor.dart';

class NetworkModule {
  NetworkModule._();

  static void register() {
    injector.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: injector<SessionManager>(),
          navigatorKey: injector<GlobalKey<NavigatorState>>(),
        ),
      );

      return dio;
    });
  }
}
