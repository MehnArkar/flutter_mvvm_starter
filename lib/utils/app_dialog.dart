import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_mvvm_starter/config/theme/app_dimensions.dart';
import 'package:flutter_mvvm_starter/utils/extensions/context_extension.dart';

/// Thin wrapper around [SmartDialog] for app-wide loading, success,
/// error, and confirmation dialogs.
class AppDialog {
  AppDialog._();

  // ─── Loading ──────────────────────────────────────────────────────────────

  static void showLoading() {
    SmartDialog.show(
      backType: SmartBackType.block,
      clickMaskDismiss: false,
      builder: (context) => Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceBright,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          alignment: Alignment.center,
          child: CupertinoActivityIndicator(
            color: context.colorScheme.primary,
            radius: 10,
          ),
        ),
      ),
    );
  }

  static Future<void> dismiss() => SmartDialog.dismiss();

  // ─── Success ──────────────────────────────────────────────────────────────

  static void showSuccess({
    String? title,
    String? message,
    String? btnLabel,
    VoidCallback? onPress,
  }) {
    SmartDialog.show(
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingDefault),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingDefault,
            vertical: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceBright,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.paddingSmallL,
            children: [
              Icon(Icons.check_circle_outline,
                  color: context.colorScheme.secondary, size: 58),
              if (title != null)
                Text(
                  title,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              if (message != null)
                Text(
                  message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ElevatedButton(
                onPressed: onPress ?? SmartDialog.dismiss,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(36),
                ),
                child: Text(
                  btnLabel ?? 'OK',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Error ────────────────────────────────────────────────────────────────

  static void showError({
    String? title,
    String? message,
    String? btnLabel,
    VoidCallback? onPress,
  }) {
    SmartDialog.show(
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingDefault),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingDefault,
            vertical: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceBright,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.paddingSmallL,
            children: [
              Icon(Icons.error_outline,
                  color: context.colorScheme.error, size: 58),
              if (title != null)
                Text(
                  title,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              if (message != null)
                Text(
                  message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ElevatedButton(
                onPressed: onPress ?? SmartDialog.dismiss,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(36),
                  backgroundColor: context.colorScheme.error,
                ),
                child: Text(
                  btnLabel ?? 'OK',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onError,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Confirm ──────────────────────────────────────────────────────────────

  static void showConfirm({
    required String title,
    String? message,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    SmartDialog.show(
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingDefault),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingDefault,
            vertical: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceBright,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.paddingSmallL,
            children: [
              Text(
                title,
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              if (message != null)
                Text(
                  message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel ?? SmartDialog.dismiss,
                      child: Text(cancelLabel ?? 'Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingSmall),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      child: Text(confirmLabel ?? 'Confirm'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
