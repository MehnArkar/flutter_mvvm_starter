import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm_starter/config/routes/app_routes.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/core/network/api_endpoints.dart';

/// Handles authentication concerns for every outgoing/incoming request:
///
/// 1. **onRequest** — injects `Authorization: Bearer <token>` header.
/// 2. **onError 401** — queues in-flight requests, calls the refresh endpoint
///    once, retries all queued requests with the new token.
///    If refresh fails, clears the session and redirects to sign-in.
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SessionManager _sessionManager;
  final GlobalKey<NavigatorState> _navigatorKey;

  bool _isRefreshing = false;
  final List<({DioException error, ErrorInterceptorHandler handler})>
      _pendingRequests = [];

  AuthInterceptor({
    required Dio dio,
    required SessionManager sessionManager,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _dio = dio,
        _sessionManager = sessionManager,
        _navigatorKey = navigatorKey;

  // ─── Inject token ─────────────────────────────────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _sessionManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ─── Handle errors ────────────────────────────────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final refreshToken = await _sessionManager.getRefreshToken();
    if (refreshToken == null) {
      await _forceLogout();
      return handler.next(err);
    }

    // Queue subsequent 401s while a refresh is already in-flight.
    if (_isRefreshing) {
      _pendingRequests.add((error: err, handler: handler));
      return;
    }

    _isRefreshing = true;
    log('[AuthInterceptor] Token expired — refreshing...');

    try {
      // Use a fresh Dio instance (no interceptors) to avoid infinite loops.
      final refreshDio = Dio(_dio.options);
      final response = await refreshDio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'x-refresh-token-transport': 'body'}),
      );

      final newToken = response.data['token'] as String;
      final newRefreshToken = response.data['refreshToken'] as String;
      final userJson = response.data['user']?.toString();

      await Future.wait([
        _sessionManager.setToken(newToken),
        _sessionManager.setRefreshToken(newRefreshToken),
        if (userJson != null) _sessionManager.setUserJson(userJson),
      ]);

      log('[AuthInterceptor] Token refreshed — retrying '
          '${_pendingRequests.length + 1} request(s)');

      for (final pending in _pendingRequests) {
        _retryRequest(pending.error, pending.handler, newToken);
      }
      _pendingRequests.clear();

      _retryRequest(err, handler, newToken);
    } catch (e) {
      log('[AuthInterceptor] Refresh failed: $e — forcing logout');
      for (final pending in _pendingRequests) {
        pending.handler.next(pending.error);
      }
      _pendingRequests.clear();
      await _forceLogout();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  Future<void> _retryRequest(
    DioException err,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    try {
      final response = await _dio.request<dynamic>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $newToken',
          },
        ),
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  Future<void> _forceLogout() async {
    await _sessionManager.clearSession();

    final context = _navigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.goNamed(AppRoutes.signIn);
    }
  }
}
