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

  List<TaskModel>? tasks; // Change to nullable to support pagination
  bool isLoadingTasks = false;
  int _localLimit = 10;
  int _localSkip = 10; // Track the current position for pagination

  // Fetch initial tasks from Hive
  void fetchAllTasks() {
    var tasksBox = Hive.box<TaskModel>(kTaskBox);
    tasks = tasksBox.values.take(_localLimit).toList(); // Fetch initial tasks based on limit
    _localSkip = _localLimit; // Update skip position
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
        tasks!.addAll(moreTasks); // Add fetched tasks to the existing list
        _localSkip += _localLimit; // Update skip position
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