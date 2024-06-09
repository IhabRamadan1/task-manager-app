import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import 'custom_app_bar.dart';
import 'custom_text_field.dart';
import 'edit_task_color_list.dart';


class EditTaskViewBody extends StatefulWidget {
  const EditTaskViewBody({Key? key, required this.task, required this.id}) : super(key: key);

  final TaskModel task;
final int id;
  @override
  State<EditTaskViewBody> createState() => _EditTaskViewBodyState();
}

class _EditTaskViewBodyState extends State<EditTaskViewBody> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskApiCubit,TaskApiState>(
      listener: (context,state){},
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CustomAppBar(
                onPressed: () {
                  widget.task.title = title ?? widget.task.title;
                  widget.task.subTitle = content ?? widget.task.subTitle;
                  widget.task.save();
                  BlocProvider.of<TaskApiCubit>(context).editTaskApi(widget.id, widget.task.title);
                  BlocProvider.of<TasksCubit>(context).fetchAllTasks();
                  BlocProvider.of<TaskApiCubit>(context).getTasksApi(limit: 10, skip: 0);

                  Navigator.pop(context);
                },
                title: 'Edit Task',
                icon: Icons.check,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                onChanged: (value) {
                  title = value;
                },
                hint: widget.task.title,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                onChanged: (value) {
                  content = value;
                },
                hint: widget.task.subTitle,
                maxLines: 5,
              ),
              const SizedBox(
                height: 16,
              ),
              EditTaskColorsList(
                task: widget.task,
              ),
            ],
          ),
        );

      },
    );
  }
}