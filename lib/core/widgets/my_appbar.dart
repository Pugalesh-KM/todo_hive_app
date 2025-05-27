import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
  super.key,
    required this.title,
    this.gradientColors = const [AppColors.primary, AppColors.primaryDark],
    this.actions,
    this.borderRadius = Dimens.standard_40,
  });

  final String title;
  final List<Color> gradientColors;
  final List<Widget>? actions;
  final double borderRadius;

  @override
  Size get preferredSize => Size.fromHeight(Dimens.standard_60);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(borderRadius),
      ),
      child: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: Colors.transparent,
        elevation: Dimens.standard_10,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: actions,
      ),
    );
  }
}