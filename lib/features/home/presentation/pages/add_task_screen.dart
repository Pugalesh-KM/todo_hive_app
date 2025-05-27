import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_strings.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';
import 'package:todo_hive_app/core/widgets/mt_text_field.dart';
import 'package:todo_hive_app/core/widgets/my_button.dart';
import '../../../../core/network/todo_service.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/my_appbar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _subtitleCtrl = TextEditingController();

  final TodoService _todoService = TodoService();

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() async {
        await _todoService.addTodo(
          title: _titleCtrl.text,
          subtitle: _subtitleCtrl.text,
        );
        Navigator.pop(context);
        AppSnackBar.showSuccess(context, AppStrings.addTask);
        _titleCtrl.clear();
        _subtitleCtrl.clear();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: AppStrings.addScreenAB),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.standard_16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextField(
                label: AppStrings.title,
                hint: AppStrings.hindTitle,
                icon: Icons.title,
                controller: _titleCtrl,
                validator: (value) =>
                value == null || value.isEmpty ? AppStrings.hindTitle : null,
              ),
              SizedBox(height: Dimens.standard_12),
              MyTextField(
                label: AppStrings.subTitle,
                hint: AppStrings.hindSubTitle,
                icon: Icons.subtitles,
                controller: _subtitleCtrl,
                validator: (value) =>
                value == null || value.isEmpty ? AppStrings.hindSubTitle: null,
              ),

              SizedBox(height: Dimens.standard_24),
              MyButton(label: AppStrings.saveButton, onPressed: _saveTask)
            ],
          ),
        ),
      ),
    );
  }
}
