import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/app_colors.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';

import '../../features/home/data/models/todo.dart';

class CardListview extends StatelessWidget {
  const CardListview({super.key,
    required this.onUpdate,
    required this.onChange, 
    required this.todo
  });

  final Todo todo;
  final VoidCallback onUpdate;
  final VoidCallback onChange;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimens.standard_8,
      surfaceTintColor: AppColors.primaryLight,
      child: ListTile(
        onTap: onUpdate,
        leading: IconButton(
            onPressed: onChange,
            icon: todo.isDone
                ? Icon(Icons.check_box,color: AppColors.primaryLight,)
                :Icon(Icons.check_box_outline_blank)
        ),
        title: Text(todo.title,
          maxLines: 1,
          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
            decoration: todo.isDone ? TextDecoration.lineThrough: null,
          ),),
        subtitle: Text(todo.subtitle,maxLines: 2,),
      ),
    );
  }
}
