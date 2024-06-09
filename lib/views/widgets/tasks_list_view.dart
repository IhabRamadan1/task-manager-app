import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_states.dart';
import 'package:task_manager_app/data/apis_models/get_all_tasks_model.dart';
import 'package:task_manager_app/data/task_manager_model.dart';
import 'package:task_manager_app/views/widgets/task_item.dart';


class TasksListView extends StatelessWidget {
  const TasksListView({Key? key, required this.todos}) : super(key: key);
  final List<Todos> todos;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        List<TaskModel> tasks = BlocProvider.of<TasksCubit>(context).tasks!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TaskItem(
                    id: todos[index].id!,
                    task: tasks[index],
                  ),
                );
              }),
        );
      },
    );
  }
}