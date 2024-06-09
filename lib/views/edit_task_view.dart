import 'package:flutter/material.dart';

import 'package:task_manager_app/models/task_manager_model.dart';
import 'package:task_manager_app/views/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({Key? key, required this.task}) : super(key: key);

  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditTaskViewBody(
        task: task,
      ),
    );
  }
}