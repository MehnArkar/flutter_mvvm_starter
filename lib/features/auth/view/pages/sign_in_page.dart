import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';
import 'package:flutter_mvvm_starter/config/routes/app_routes.dart';
import 'package:flutter_mvvm_starter/core/di/service_locator.dart';
import 'package:flutter_mvvm_starter/features/auth/data/models/user_model.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/sign_in_cubit.dart';
import 'package:flutter_mvvm_starter/utils/app_dialog.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';
import 'package:flutter_mvvm_starter/utils/extensions/context_extension.dart';
import 'package:flutter_mvvm_starter/utils/validators/form_validators.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<SignInCubit>(),
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
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SignInCubit>().signIn(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, DefaultState<UserModel>>(
      listener: (context, state) {
        state.when(
          init: () {},
          loading: AppDialog.showLoading,
          success: (_) {
            AppDialog.dismiss();
            context.goNamed(AppRoutes.home);
          },
          fail: (failure) {
            AppDialog.dismiss();
            AppDialog.showError(message: failure.message);
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
                          'Demo login — enter any email and password.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLargeL),

                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: FormValidator.email().call,
                  ),
                  const SizedBox(height: AppDimensions.paddingDefault),

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
