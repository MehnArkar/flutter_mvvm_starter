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
///    If refresh fails, clears session and redirects to sign-in.
/// 3. **onError 403 PASSWORD_CHANGE_REQUIRED** — force-clears session and
///    redirects to sign-in immediately.
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
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _sessionManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  // ─── Handle errors ────────────────────────────────────────────────────────

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // ── 403: force password change ─────────────────────────────────────────
    if (err.response?.statusCode == 403) {
      final data = err.response?.data;
      if (data is Map && data['code'] == 'PASSWORD_CHANGE_REQUIRED') {
        log('[AuthInterceptor] PASSWORD_CHANGE_REQUIRED — force logout');
        await _forceLogout();
        return super.onError(err, handler);
      }
    }

    // ── 401: attempt token refresh ─────────────────────────────────────────
    if (err.response?.statusCode == 401) {
      final refreshToken = await _sessionManager.getRefreshToken();
      if (refreshToken == null) {
        await _forceLogout();
        return super.onError(err, handler);
      }

      // Queue subsequent 401s while refresh is in-flight
      if (_isRefreshing) {
        _pendingRequests.add((error: err, handler: handler));
        return;
      }

      _isRefreshing = true;
      log('[AuthInterceptor] Token expired — refreshing...');

      try {
        // Use a fresh Dio (no interceptors) to avoid an infinite loop
        final refreshDio = Dio(_dio.options);
        final response = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken, 'deviceName': null},
          options: Options(
            headers: {'x-refresh-token-transport': 'body'},
          ),
        );

        final newToken = response.data['token'] as String;
        final newRefreshToken = response.data['refreshToken'] as String;
        // Raw user JSON — the auth feature handles deserialization
        final userJson = response.data['user'] != null
            ? response.data['user'].toString()
            : null;

        await _sessionManager.setToken(newToken);
        await _sessionManager.setRefreshToken(newRefreshToken);
        if (userJson != null) await _sessionManager.setUserJson(userJson);

        log('[AuthInterceptor] Token refreshed — retrying ${_pendingRequests.length + 1} request(s)');

        // Retry pending requests with new token
        for (final pending in _pendingRequests) {
          _retryRequest(pending.error, pending.handler, newToken);
        }
        _pendingRequests.clear();

        // Retry the original request
        _retryRequest(err, handler, newToken);
      } catch (e) {
        log('[AuthInterceptor] Refresh failed: $e — force logout');
        for (final pending in _pendingRequests) {
          pending.handler.reject(pending.error);
        }
        _pendingRequests.clear();
        await _forceLogout();
        super.onError(err, handler);
      } finally {
        _isRefreshing = false;
      }
      return;
    }

    super.onError(err, handler);
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  void _retryRequest(
    DioException err,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    try {
      final opts = Options(
        method: err.requestOptions.method,
        headers: {
          ...err.requestOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
      );
      final response = await _dio.request<dynamic>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: opts,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  Future<void> _forceLogout() async {
    for (final pending in _pendingRequests) {
      pending.handler.reject(pending.error);
    }
    _pendingRequests.clear();
    _isRefreshing = false;

    await _sessionManager.clearSession();

    final context = _navigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.goNamed(AppRoutes.signIn);
    }
  }
}
