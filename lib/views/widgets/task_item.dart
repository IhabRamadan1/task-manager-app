import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/data/task_manager_model.dart';
import 'package:task_manager_app/views/edit_task_view.dart';


class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task, required this.id}) : super(key: key);
  final TaskModel task;
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskApiCubit, TaskApiState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EditTaskView(
                  task: task,
                  id: id,
                );
              }),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(task.color),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.only(left: 16, top: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      task.subTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(.4),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<TaskApiCubit>(context).deleteTaskApi(id);
                      task.delete();
                      BlocProvider.of<TasksCubit>(context).fetchAllTasks();
                      BlocProvider.of<TaskApiCubit>(context).getTasksApi(
                          limit: 10, skip: 0);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    task.date,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

  }
}