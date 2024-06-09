import 'package:flutter/material.dart';
import 'widgets/add_task_bottom_sheet.dart';
import 'widgets/tasks_view_body.dart';


class TaskManagerView extends StatelessWidget {
  const TaskManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              context: context,
              builder: (context) {
                return const AddTaskBottomSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
      body:  const TasksViewBody(),
    );
  }
}