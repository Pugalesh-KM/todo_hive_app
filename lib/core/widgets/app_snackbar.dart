import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';

class AppSnackBar {
  ///  success
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  /// undo
  static void showUndo(
    BuildContext context,
    String message,
    VoidCallback onPressed,
  ) {
    _showSnackBar(
      context,
      message,
      action: SnackBarAction(
        label: "Undo",
        onPressed: onPressed,
        textColor: AppColors.primary,
      ),
      backgroundColor: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  ///  error
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: AppColors.error,
      icon: Icons.error,
    );
  }

  ///  neutral info
  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: AppColors.primaryLight,
      icon: Icons.info,
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColors.white),
            const SizedBox(width: Dimens.standard_12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: Dimens.standard_18,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: Dimens.standard_16,
          vertical: Dimens.standard_12,
        ),
        elevation: Dimens.standard_6,
        duration: const Duration(seconds: 3),
        action: action,
      ),
    );
  }
}
