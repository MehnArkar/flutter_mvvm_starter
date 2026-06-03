import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm_starter/config/routes/app_routes.dart';
import 'package:flutter_mvvm_starter/features/auth/view/pages/sign_in_page.dart';
import 'package:flutter_mvvm_starter/features/splash/view/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  /// Shared navigator key — injected into [AuthInterceptor] so it can
  /// programmatically navigate (e.g. force-logout on 403).
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${AppRoutes.splash}',
    observers: [FlutterSmartDialog.observer],
    routes: [
      GoRoute(
        path: '/${AppRoutes.splash}',
        name: AppRoutes.splash,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/${AppRoutes.signIn}',
        name: AppRoutes.signIn,
        builder: (_, __) => const SignInPage(),
      ),
      GoRoute(
        path: '/${AppRoutes.home}',
        name: AppRoutes.home,
        // TODO: replace with your real HomePage
        builder: (_, __) => const _PlaceholderHomePage(),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Placeholder — remove once a real home feature exists
// ---------------------------------------------------------------------------
class _PlaceholderHomePage extends StatelessWidget {
  const _PlaceholderHomePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}
