import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';
import 'package:flutter_mvvm_starter/features/auth/viewModel/change_password_cubit.dart';
import 'package:flutter_mvvm_starter/utils/app_dialog.dart';
import 'package:flutter_mvvm_starter/utils/bloc/states/default_state.dart';
import 'package:flutter_mvvm_starter/utils/extensions/context_extension.dart';
import 'package:flutter_mvvm_starter/utils/validators/form_validators.dart';

/// Modal bottom sheet shown when [mustChangePassword] = true after login,
/// or from a profile/settings screen for a voluntary password change.
///
/// Usage:
/// ```dart
/// ChangePasswordSheet.show(context);
/// ```
class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ChangePasswordCubit>(),
        child: const ChangePasswordSheet(),
      ),
    );
  }

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<ChangePasswordCubit>().changePassword(
          currentPassword: _currentCtrl.text,
          newPassword: _newCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, DefaultState<bool>>(
      listener: (context, state) {
        state.when(
          init: () {},
          loading: AppDialog.showLoading,
          success: (_) {
            AppDialog.dismiss();
            Navigator.of(context).pop(true); // signal success to caller
          },
          fail: (failure) {
            AppDialog.dismiss();
            AppDialog.showError(message: failure.message);
          },
          requiresAction: (_) {},
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.paddingMedium,
          right: AppDimensions.paddingMedium,
          top: AppDimensions.paddingLarge,
          bottom: AppDimensions.paddingMedium +
              MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Header ─────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Change Password',
                      style: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingMedium),

              // ─── Current password ────────────────────────────────────────
              TextFormField(
                controller: _currentCtrl,
                obscureText: _obscureCurrent,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  suffixIcon: _ToggleObscure(
                    obscure: _obscureCurrent,
                    onToggle: () =>
                        setState(() => _obscureCurrent = !_obscureCurrent),
                  ),
                ),
                validator: FormValidator.minLength(6, 'Current password').call,
              ),
              const SizedBox(height: AppDimensions.paddingSmall),

              // ─── New password ────────────────────────────────────────────
              TextFormField(
                controller: _newCtrl,
                obscureText: _obscureNew,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: _ToggleObscure(
                    obscure: _obscureNew,
                    onToggle: () =>
                        setState(() => _obscureNew = !_obscureNew),
                  ),
                ),
                validator: FormValidator.minLength(6, 'New password').call,
              ),
              const SizedBox(height: AppDimensions.paddingSmall),

              // ─── Confirm password ────────────────────────────────────────
              TextFormField(
                controller: _confirmCtrl,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: _ToggleObscure(
                    obscure: _obscureConfirm,
                    onToggle: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator: (_) =>
                    FormValidator.confirmMatch(_confirmCtrl.text, _newCtrl.text),
              ),
              const SizedBox(height: AppDimensions.paddingLarge),

              // ─── Submit ──────────────────────────────────────────────────
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Change Password'),
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Small helper widget ─────────────────────────────────────────────────────

class _ToggleObscure extends StatelessWidget {
  const _ToggleObscure({required this.obscure, required this.onToggle});

  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      onPressed: onToggle,
    );
  }
}
