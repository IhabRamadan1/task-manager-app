import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';

import 'custom_app_bar.dart';
import 'tasks_list_view.dart';



class TasksViewBody extends StatefulWidget {
  const TasksViewBody({Key? key}) : super(key: key);

  @override
  State<TasksViewBody> createState() => _TasksViewBodyState();
}

class _TasksViewBodyState extends State<TasksViewBody> {

  @override
  void initState() {
    BlocProvider.of<TasksCubit>(context).fetchAllTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomAppBar(
            title: 'Tasks',
            icon: Icons.task_alt,
          ),
          Expanded(
            child: TasksListView(),
          ),
        ],
      ),
    );
  }
}