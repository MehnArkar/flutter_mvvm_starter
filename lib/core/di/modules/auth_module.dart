import 'package:dio/dio.dart';
import 'package:flutter_mvvm_starter/core/di/service_locator.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/logout_cubit.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/sign_in_cubit.dart';

class AuthModule {
  AuthModule._();

  static void register() {
    injector.registerLazySingleton(
      () => AuthDataSource(dio: injector<Dio>()),
    );
    injector.registerLazySingleton(
      () => AuthRepository(dataSource: injector<AuthDataSource>()),
    );

    // Cubits are factories — a fresh instance is created per page/provider.
    injector.registerFactory(
      () => SignInCubit(
        authRepository: injector<AuthRepository>(),
        sessionManager: injector<SessionManager>(),
      ),
    );
    injector.registerFactory(
      () => LogoutCubit(
        authRepository: injector<AuthRepository>(),
        sessionManager: injector<SessionManager>(),
      ),
    );
  }
}
