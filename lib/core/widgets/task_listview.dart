import 'package:flutter/material.dart';
import 'package:todo_hive_app/core/constants/dimens.dart';

class TaskListview extends StatelessWidget {
  const TaskListview({super.key,
    required this.itemCount,
    required this.itemBuilder});

  final int itemCount;
  final Widget? Function(BuildContext,int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(Dimens.standard_2),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: itemBuilder,
        itemCount: itemCount
    );
  }
}
