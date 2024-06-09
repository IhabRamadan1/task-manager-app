import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_states.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import '../../core/constants/constants.dart';


class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TaskInitial());

  // List<TaskModel>? tasks;
  // fetchAllTasks() {
  //   var tasksBox = Hive.box<TaskModel>(kTaskBox);
  //   tasks = tasksBox.values.toList();
  //   emit(TaskSuccess());
  // }

  List<TaskModel>? tasks;
  bool isLoadingTasks = false;
  int _localLimit = 10;
  int _localSkip = 0;

  // Fetch initial tasks from Hive
  void fetchAllTasks() {
    var tasksBox = Hive.box<TaskModel>(kTaskBox);
    tasks = tasksBox.values.take(_localLimit).toList();
    // Update skip position
    _localSkip = _localLimit;
    emit(TaskSuccess());
  }

  // Fetch more tasks from Hive for pagination
  void fetchMoreTasks() {
    if (isLoadingTasks) return;
    isLoadingTasks = true;
    emit(GetTasksLoading());
    try {
      var tasksBox = Hive.box<TaskModel>(kTaskBox);
      final moreTasks = tasksBox.values.skip(_localSkip).take(_localLimit).toList(); // Fetch more tasks based on limit and skip
      if (moreTasks.isNotEmpty) {
        // Add fetched tasks to the existing list
        tasks!.addAll(moreTasks);
        // Update skip position
        _localSkip += _localLimit;
        emit(GetTasksSuccess());
      } else {
        emit(GetTasksFailure("No more tasks available")); // Emit failure if no more tasks available
      }
    } catch (e) {
      emit(GetTasksFailure(e.toString()));
    } finally {
      isLoadingTasks = false;
    }
  }
}