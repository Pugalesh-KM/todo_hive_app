import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';

class MyButton extends StatelessWidget {

  const MyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.elevation = Dimens.standard_4,
    this.borderRadius = Dimens.standard_14,
    this.padding = const EdgeInsets.symmetric(
        horizontal: Dimens.standard_24, vertical: Dimens.standard_16),
  });


  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsets padding;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        disabledBackgroundColor: backgroundColor.withOpacity(Dimens.decimal_6),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      child: isLoading
          ? const SizedBox(
        height: Dimens.standard_22,
        width: Dimens.standard_22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: Dimens.standard_20),
            const SizedBox(width: Dimens.standard_8),
          ],
          Text(label),
        ],
      ),
    );
  }
}
