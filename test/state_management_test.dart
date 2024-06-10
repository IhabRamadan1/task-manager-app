import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/data/apis_models/add_new_task_model.dart';


void main() {
  group('State Management', () {
    test('Initial State', () {
      final taskState = TaskApiCubit();
      expect(taskState.tasks, []);
    });

    test('Add Task', () {
      final taskState = TaskApiCubit();
      final task = AddNewTaskModel(id: 1, todo: 'Test Task');
      taskState.addTaskApi(task.todo!);
      expect(taskState.tasks.contains(task), true);
    });

    test('Remove Task', () {
      final taskState = TaskApiCubit();
      final task = AddNewTaskModel(id: 1, todo:
      'Test Task');
      taskState.addTaskApi(task.todo!);
      taskState.deleteTaskApi(task.id!);
      expect(taskState.tasks.contains(task), false);
    });

    test('Update Task', () {
      final taskState = TaskApiCubit();
      final task =AddNewTaskModel(id: 1, todo:
      'Test Task');
      taskState.addTaskApi(task.todo!);
      final updatedTask = AddNewTaskModel(id: 1, todo:
      'Test Task');
      taskState.editTaskApi(updatedTask.id!,updatedTask.todo!);
      expect(taskState.tasks.firstWhere((t) => t.id == '1').title, 'Updated Task');
    });
  });
}
