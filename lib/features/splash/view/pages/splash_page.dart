import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm_starter/config/routes/app_routes.dart';
import 'package:flutter_mvvm_starter/core/local/session_manager.dart';
import 'package:flutter_mvvm_starter/features/auth/data/repositories/auth_repository.dart';

/// Entry point of the app.
///
/// Reads persisted session and routes accordingly:
///   - logged in  → [AppRoutes.home]
///   - logged out → [AppRoutes.signIn]
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Small delay so the splash is visible for at least one frame.
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final sessionManager = SessionManager();

    if (await sessionManager.isLoggedIn) {
      final userJson = await sessionManager.getUserJson();
      final user = AuthRepository.userFromJson(userJson);

      if (!mounted) return;
      if (user != null) {
        context.goNamed(AppRoutes.home);
      } else {
        // Token exists but user data is corrupt — treat as logged out.
        await sessionManager.clearSession();
        if (!mounted) return;
        context.goNamed(AppRoutes.signIn);
      }
    } else {
      context.goNamed(AppRoutes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 80),
      ),
    );
  }
}
