import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';

import 'add_task_form.dart';


class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskApiCubit, TaskApiState>(
      listener: (context, state) {
        if (state is AddTaskFailure) {}
        if (state is AddTaskLocallySuccess) {
          BlocProvider.of<TasksCubit>(context).fetchAllTasks();
          Navigator.pop(context);
        }
        if (state is AddTaskSuccess) {
          BlocProvider.of<TaskApiCubit>(context).getTasksApi(limit: 10, skip: 0);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is AddTaskLoading ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SingleChildScrollView(
              child: AddTaskForm(),
            ),
          ),
        );
      },
    );
  }
}