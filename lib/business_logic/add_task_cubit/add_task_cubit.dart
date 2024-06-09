import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_manager_app/constants.dart';
import 'package:task_manager_app/models/task_manager_model.dart';
import 'add_task_states.dart';




class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  Color color = const Color(0xffAC3931);
  addTask(TaskModel task) async {
    task.color = color.value;
    emit(AddTaskLoading());
    try {
      var tasksBox = Hive.box<TaskModel>(kTaskBox);
      await tasksBox.add(task);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailure(e.toString()));
    }
  }
}