import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_strings.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';
import 'package:todo_hive_app/core/widgets/my_button.dart';

import '../../../../core/network/todo_service.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/mt_text_field.dart';
import '../../../../core/widgets/my_appbar.dart';
import '../../data/models/todo.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key, required this.index, required this.todo});

  final int index;
  final Todo todo;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _subtitleCtrl;

  final TodoService _todoService = TodoService();

  @override
  void initState() {
    _titleCtrl = TextEditingController(text: widget.todo.title);
    _subtitleCtrl = TextEditingController(text: widget.todo.subtitle);
    super.initState();
  }

  void _updateTask() async {
    if (_formKey.currentState!.validate()) {
      await _todoService.updateTodo(
        index: widget.index,
        newTitle: _titleCtrl.text,
        newSubtitle: _subtitleCtrl.text,
        isDone: widget.todo.isDone,
      );
      Navigator.pop(context);
      AppSnackBar.showSuccess(context, AppStrings.updateTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title:
            widget.todo.isDone
                ? AppStrings.completeTask
                : AppStrings.updateScreenAB,
      ),
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
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? AppStrings.hindTitle
                            : null,
              ),
              SizedBox(height: Dimens.standard_12),
              MyTextField(
                label: AppStrings.subTitle,
                hint: AppStrings.hindSubTitle,
                icon: Icons.subtitles,
                controller: _subtitleCtrl,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? AppStrings.hindSubTitle
                            : null,
              ),
              SizedBox(height: Dimens.standard_24),

              MyButton(
                label:
                    widget.todo.isDone
                        ? AppStrings.completeTask
                        : AppStrings.updateButton,
                onPressed: _updateTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
