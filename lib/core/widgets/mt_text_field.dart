import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';

import '../constants/dimens.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
  });


  final String label;
  final String? hint;
  final IconData? icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: AppColors.primaryLight) : null,
        filled: true,
        fillColor: AppColors.primaryLight.withOpacity(Dimens.decimal_3),
        contentPadding: const EdgeInsets.symmetric(vertical: Dimens.standard_16, horizontal: Dimens.standard_20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: Dimens.standard_2),
        ),
      ),
      style: const TextStyle(fontSize: 22),
    );
  }
}

