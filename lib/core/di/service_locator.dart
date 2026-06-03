import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
    _registerCore();
    NetworkModule.register();
    AuthModule.register();
  }

  static void _registerCore() {
    // Navigator key — shared by AppRouter and AuthInterceptor.
    injector.registerSingleton<GlobalKey<NavigatorState>>(AppRouter.navigatorKey);

    // Storage
    injector.registerLazySingleton<SessionManager>(
      () => SessionManager(),
    );
    injector.registerLazySingleton<LocalDataSource>(
      () => LocalDataSource(),
    );
  }
}
