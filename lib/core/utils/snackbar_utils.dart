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
