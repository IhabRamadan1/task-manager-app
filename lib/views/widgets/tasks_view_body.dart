import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/core/constants/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'custom_app_bar.dart';
import 'tasks_list_view.dart';

class TasksViewBody extends StatefulWidget {
  const TasksViewBody({Key? key}) : super(key: key);
  @override
  State<TasksViewBody> createState() => _TasksViewBodyState();
}

class _TasksViewBodyState extends State<TasksViewBody> {

  RefreshController refreshControllerEmployer =
  RefreshController(initialRefresh: false);
  int limit = 10;
  int skip = 0;

  @override
  void initState() {
    BlocProvider.of<TasksCubit>(context).fetchAllTasks(limit);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
     create: (context)=> TaskApiCubit()..getTasksApi(limit: limit, skip: skip),
      child: BlocConsumer<TaskApiCubit,TaskApiState>(
        listener: (context,state){},
        builder: (context,state){
          return
           Padding(
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
                 child: SmartRefresher(
                   controller: refreshControllerEmployer,
                   enablePullDown: true,
                   enablePullUp: true,
                   header: const WaterDropHeader(),
                   onRefresh: () async {
                     print('a');
                     refreshControllerEmployer.refreshCompleted();
                   },
                   onLoading: () {
                     // setState(() {
                     if (TaskApiCubit.get(context)
                         .todosPagination
                         .length >=
                         10 &&
                         limit !=
                             TaskApiCubit.get(context)
                                 .getAllTasksModel!
                                 .total) {
                       skip = limit;
                       limit+=10;
                       TaskApiCubit.get(context)
                           .getTasksApi(limit: limit, skip: skip);
                       BlocProvider.of<TasksCubit>(context).fetchAllTasks(limit: limit, skip: skip);
                       refreshControllerEmployer.loadComplete();
                       print('completed $skip $limit');
                     } else {
                       refreshControllerEmployer.loadNoData();
                     }
                     // });
                   },
                   child: TasksListView(
                     todos: BlocProvider.of<TaskApiCubit>(context).todosPagination,
                   ),
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