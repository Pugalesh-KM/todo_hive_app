import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';

class MyFab extends StatelessWidget {
  const MyFab({super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor = AppColors.primary,
    this.iconColor = AppColors.white,
    this.elevation = Dimens.standard_6,
    this.shape ,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor ;
  final double elevation;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      child: Icon(icon, color: iconColor),
    );
  }
}
