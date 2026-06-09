import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mvvm_starter/config/routes/app_router.dart';
import 'package:flutter_mvvm_starter/core/di/modules/auth_module.dart';
import 'package:flutter_mvvm_starter/core/di/modules/network_module.dart';
import 'package:flutter_mvvm_starter/core/local/local_data_source.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';

/// Global service locator instance.
/// Call [ServiceLocator.injectDependencies] once in [main] before [runApp].
final GetIt injector = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static Future<void> injectDependencies() async {
    await _registerCore();
    NetworkModule.register();
    AuthModule.register();
  }

  static Future<void> _registerCore() async {
    // Navigator key — shared by AppRouter and AuthInterceptor.
    injector.registerSingleton<GlobalKey<NavigatorState>>(
      AppRouter.navigatorKey,
    );

    // Secure session storage.
    injector.registerLazySingleton<SessionManager>(() => SessionManager());

    // Non-sensitive preferences — SharedPreferences is initialized once here
    // and injected so LocalDataSource has no mutable init() lifecycle.
    final prefs = await SharedPreferences.getInstance();
    injector.registerSingleton<SharedPreferences>(prefs);
    injector.registerLazySingleton<LocalDataSource>(
      () => LocalDataSource(prefs: injector<SharedPreferences>()),
    );
  }
}
