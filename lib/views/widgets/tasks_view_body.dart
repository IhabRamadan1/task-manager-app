import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/business_logic/auth_cubit/auth_states.dart';
import 'package:task_manager_app/business_logic/auth_cubit/auth_cubit.dart';
import 'package:task_manager_app/core/constants/constants.dart';

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
    return  BlocProvider(
     create: (context)=> TaskApiCubit()..getTasksApi(limit: 10, skip: 10),
      child: BlocConsumer<TaskApiCubit,TaskApiState>(
        listener: (context,state){},
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
            BlocProvider.of<TaskApiCubit>(context).getAllTasksModel != null?
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const CustomAppBar(
                  title: 'Tasks',
                  icon: Icons.task_alt,
                ),
                Expanded(
                  child: TasksListView(
                    todos: BlocProvider.of<TaskApiCubit>(context).getAllTasksModel!.todos!,
                  ),
                ),
              ],
            ):
            const Center(child: CircularProgressIndicator(
              color:kPrimaryColor,
            ),)
            ,
          );
        },
      ),
    );

  }
}