import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class SnackbarUtils {
  /// Shows a success snackbar with green background
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarSuccess,
      icon: Icons.check_circle,
      duration: duration,
      action: action,
    );
  }

  /// Shows an error snackbar with red background
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarError,
      icon: Icons.error,
      duration: duration,
      action: action,
    );
  }

  /// Shows a warning snackbar with orange background
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarWarning,
      icon: Icons.warning,
      duration: duration,
      action: action,
    );
  }

  /// Shows an info snackbar with blue background
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarInfo,
      icon: Icons.info,
      duration: duration,
      action: action,
    );
  }

  /// Shows a custom snackbar with specified properties
  static void showCustom(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    EdgeInsetsGeometry? margin,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
      action: action,
      margin: margin,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
    );
  }

  /// Shows a snackbar with action button
  static void showWithAction(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Color backgroundColor = AppColors.snackbarInfo,
    Duration duration = const Duration(seconds: 5),
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: backgroundColor,
      duration: duration,
      action: SnackBarAction(
        label: actionLabel,
        onPressed: onActionPressed,
        textColor: Colors.white,
      ),
    );
  }

  /// Shows a snackbar for network errors with retry option
  static void showNetworkError(
    BuildContext context, {
    String message = AppStrings.networkErrorMessage,
    VoidCallback? onRetry,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarError,
      icon: Icons.wifi_off,
      duration: const Duration(seconds: 5),
      action: onRetry != null
          ? SnackBarAction(
              label: AppStrings.retryAction,
              onPressed: onRetry,
              textColor: AppColors.textOnPrimary,
            )
          : null,
    );
  }

  /// Shows a snackbar for permission denied with settings option
  static void showPermissionDenied(
    BuildContext context, {
    String message = AppStrings.permissionDeniedMessage,
    VoidCallback? onSettings,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: AppColors.snackbarWarning,
      icon: Icons.block,
      duration: const Duration(seconds: 5),
      action: onSettings != null
          ? SnackBarAction(
              label: AppStrings.settingsAction,
              onPressed: onSettings,
              textColor: AppColors.textOnPrimary,
            )
          : null,
    );
  }

  /// Private method to show the actual snackbar
  static void _showSnackbar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    EdgeInsetsGeometry? margin,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
  }) {
    if (!context.mounted) return;

    final snackBar = SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.textOnPrimary, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.textOnPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? AppColors.gray900,
      duration: duration,
      action: action,
      margin: margin,
      elevation: elevation ?? 6,
      shape: shape,
      behavior: behavior ?? SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Dismisses all snackbars
  static void dismissAll(BuildContext context) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
