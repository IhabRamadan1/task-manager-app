import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/apis_models/add_new_task_model.dart';
import 'package:task_manager_app/data/apis_models/get_all_tasks_model.dart';
import 'package:task_manager_app/services/task_service.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  late TaskService taskService;

  setUp(() {
    taskService = MockTaskService();
  });

  group('Task CRUD operations', () {
    test('Create Task', () async {
      final task = AddNewTaskModel(id: 1, todo:
      'Test Task');
      when(taskService.createTask(task)).thenAnswer((_) async => task);

      final createdTask = await taskService.createTask(task);

      expect(createdTask.todo, 'Test Task');
      expect(createdTask.id, 'id');
    });

    test('Read Tasks', () async {
      final tasks = [GetAllTasksModel()];
      when(taskService.fetchTasks()).thenAnswer((_) async => tasks);

      final fetchedTasks = await taskService.fetchTasks();

      expect(fetchedTasks.length, 1);
      expect(fetchedTasks[0].todos![0].todo, 'Test Task');
    });

    test('Update Task', () async {
      final task = AddNewTaskModel(id: 1, todo:
      'Test Task');
      when(taskService.updateTask(task)).thenAnswer((_) async {});

      await taskService.updateTask(task);

      verify(taskService.updateTask(task)).called(1);
    });

    test('Delete Task', () async {
      when(taskService.deleteTask('1')).thenAnswer((_) async {});

      await taskService.deleteTask('1');

      verify(taskService.deleteTask('1')).called(1);
    });
  });
}
