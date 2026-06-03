import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';
import 'package:flutter_mvvm_starter/config/routes/app_routes.dart';
import 'package:flutter_mvvm_starter/core/di/service_locator.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_model.dart';
import 'package:flutter_mvvm_starter/features/auth/view/widgets/change_password_sheet.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/change_password_cubit.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/sign_in_cubit.dart';
import 'package:flutter_mvvm_starter/utils/app_dialog.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';
import 'package:flutter_mvvm_starter/utils/extensions/context_extension.dart';
import 'package:flutter_mvvm_starter/utils/validators/form_validators.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<SignInCubit>()),
        BlocProvider(create: (_) => injector<ChangePasswordCubit>()),
      ],
      child: const _SignInView(),
    );
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SignInCubit>().signIn(
          username: _usernameCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, DefaultState<UserModel>>(
      listener: (context, state) async {
        state.when(
          init: () {},
          loading: AppDialog.showLoading,
          success: (user) {
            AppDialog.dismiss();
            context.goNamed(AppRoutes.home);
          },
          fail: (failure) {
            AppDialog.dismiss();
            AppDialog.showError(message: failure.message);
          },
          requiresAction: (user) async {
            AppDialog.dismiss();
            // Forced password change — show bottom sheet.
            final changed = await ChangePasswordSheet.show(context);
            if (changed == true && context.mounted) {
              await context.read<SignInCubit>().completeSignIn();
              if (context.mounted) context.goNamed(AppRoutes.home);
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceBright,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingLarge,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // ─── Logo / Title ──────────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        const FlutterLogo(size: 72),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        Text(
                          'Sign In',
                          style: context.textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppDimensions.paddingSmall),
                        Text(
                          'Welcome back! Please sign in to continue.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLargeL),

                  // ─── Username ──────────────────────────────────────────
                  TextFormField(
                    controller: _usernameCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Username / Email',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: FormValidator.required('Username').call,
                  ),
                  const SizedBox(height: AppDimensions.paddingDefault),

                  // ─── Password ──────────────────────────────────────────
                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: FormValidator.minLength(6, 'Password').call,
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // ─── Submit ────────────────────────────────────────────
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                          AppDimensions.buttonHeight),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
