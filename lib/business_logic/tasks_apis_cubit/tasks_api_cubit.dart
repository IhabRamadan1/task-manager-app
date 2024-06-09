import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/core/constants/constants.dart';
import 'package:task_manager_app/core/network_services/end_points.dart';
import 'package:task_manager_app/core/network_services/remote/dio_helper.dart';
import 'package:task_manager_app/data/apis_models/get_all_tasks_model.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import 'tasks_api_states.dart';

class TaskApiCubit extends Cubit<TaskApiState> {
  TaskApiCubit() : super(TaskInitial());

  // add task locally using hive

  Color color = const Color(0xffAC3931);
  addTaskLocally(TaskModel task) async {
    task.color = color.value;
    emit(AddTaskLocallyLoading());
    try {
      var tasksBox = Hive.box<TaskModel>(kTaskBox);
      await tasksBox.add(task);
      emit(AddTaskLocallySuccess());
    } catch (e) {
      emit(AddTaskLocallyFailure(e.toString()));
    }
  }

  List<dynamic> tasks = [];
  bool isLoadingTasks = false;

  // add task using api
  void addTaskApi(String title) async {
    emit(AddTaskLoading());
    try {
      final response = await DioHelper.postData(
        url: addTaskEndPoint,
        data: {
          'title': title,
          'completed': false,
        },
      );
      tasks.add(response.data);
      emit(AddTaskSuccess());
    } catch (e) {

      emit(AddTaskFailure(e.toString()));
    }
  }

  GetAllTasksModel? getAllTasksModel;
  void getTasksApi({required int limit, required int skip}) async {
    if (isLoadingTasks) return;
    isLoadingTasks = true;
    emit(GetTasksLoading());
    try {
      final response = await DioHelper.getData(
        url: displayTasksEndPoint,
        query: {
          'limit': limit,
          'skip': skip,
        },
      );
      getAllTasksModel = GetAllTasksModel.fromJson(response.data);
      tasks.addAll(response.data['todos']);
      emit(GetTasksSuccess());
    } catch (e) {
      emit(GetTasksFailure(e.toString()));
    } finally {
      isLoadingTasks = false;
    }
  }

  void editTaskApi(int id, String title) async {
    emit(EditTaskLoading());
    try {
      final response = await DioHelper.putData(
        url: 'todos/$id',
        data: {
          'title': title,
        },
      );
      final index = tasks.indexWhere((task) => task['id'] == id);
      if (index != -1) {
        tasks[index] = response.data;
      }

      emit(EditTaskSuccess());
    } catch (e) {
      emit(EditTaskFailure(e.toString()));
    }
  }

  void deleteTaskApi(int id) async {
    emit(DeleteTaskLoading());
    try {
      await DioHelper.deleteData(url: 'todos/$id');
      tasks.removeWhere((task) => task['id'] == id);
      emit(DeleteTaskSuccess());
    } catch (e) {
      emit(DeleteTaskFailure(e.toString()));
    }
  }
}