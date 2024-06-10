import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_states.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import '../../core/constants/constants.dart';


class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TaskInitial());

  List<TaskModel>? tasks;
  fetchAllTasks() {
    var tasksBox = Hive.box<TaskModel>(kTaskBox);
    tasks = tasksBox.values.toList();
    emit(TaskSuccess());
  }

}