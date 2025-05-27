import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_app/core/constants/app_strings.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';
import 'package:todo_hive_app/core/network/todo_service.dart';
import 'package:todo_hive_app/core/widgets/app_snackbar.dart';
import 'package:todo_hive_app/core/widgets/card_listview.dart';
import 'package:todo_hive_app/core/widgets/my_appbar.dart';
import 'package:todo_hive_app/core/widgets/my_fab.dart';
import 'package:todo_hive_app/core/widgets/task_listview.dart';
import 'package:todo_hive_app/features/home/data/models/todo.dart';
import 'package:todo_hive_app/features/home/presentation/pages/add_task_screen.dart';
import 'package:todo_hive_app/features/home/presentation/pages/update_task_screen.dart';

import '../../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoService = TodoService();
  final Box<Todo> todoBox = Hive.box<Todo>('todos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppStrings.homeScreenAB,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final deletedTodos = await todoService.deleteCompletedTodos();
              if (!mounted) return;
              AppSnackBar.showUndo(
                context,
                "All completed tasks deleted",
                () async {
                  await todoService.restoreTodos(deletedTodos);
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: MyFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<Todo> box, _) {
          final todos = box.values.toList();

          if (todoBox.isEmpty) {
            return Center(child: Text(AppStrings.homeScreenEmpty));
          }

          final sortedTodos = [
            ...todos.where((todo) => !todo.isDone),
            ...todos.where((todo) => todo.isDone),
          ];

          return TaskListview(
            itemCount: sortedTodos.length,
            itemBuilder: (context, index) {
              final todo = sortedTodos[index];
              final key = todo.key as int;
              return Dismissible(
                key: Key(key.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors.error,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.standard_20),
                  child: const Icon(Icons.delete, color: AppColors.white),
                ),
                onDismissed: (_) async {
                  final deletedTodo = todo;
                  await todoService.deleteTodo(key);
                  if (!mounted) return;
                  AppSnackBar.showUndo(
                    context,
                    AppStrings.deleteTask,
                    () async {
                      await todoService.undoTodo(deletedTodo);
                    },
                  );
                },
                child: CardListview(
                  todo: todo,
                  onChange: () async {
                    await todoService.toggleDone(key);
                    final isDone = todo.isDone;
                    if (isDone) {
                      AppSnackBar.showSuccess(context, AppStrings.completeTask);
                    } else {
                      AppSnackBar.showError(
                        context,
                        AppStrings.notCompleteTask,
                      );
                    }
                  },
                  onUpdate:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => UpdateTaskScreen(index: key, todo: todo),
                        ),
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
