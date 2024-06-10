import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/apis_models/add_new_task_model.dart';
import 'package:task_manager_app/services/task_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late TaskService taskService;

  setUp(() {
    client = MockClient();
    taskService = TaskService(client);
  });

  group('Network Requests', () {
    test('Fetch Tasks', () async {
      when(client.get(Uri.parse('https://reqres.in/api/tasks')))
          .thenAnswer((_) async => http.Response('{"data": []}', 200));

      var tasks = await taskService.fetchTasks();
      expect(tasks, []);
    });

    test('Create Task', () async {
      final task =
      AddNewTaskModel(id: 1, todo:
      'Test Task');
      when(client.post(
        Uri.parse('https://reqres.in/api/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      )).thenAnswer((_) async => http.Response(json.encode(task.toJson()), 201));

      var createdTask = await taskService.createTask(task);
      expect(createdTask.todo, 'Test Task');
      expect(createdTask.id, 'id');
    });

    test('Update Task', () async {
      final task = AddNewTaskModel(id: 1, todo:
      'Test Task');
      when(client.put(
        Uri.parse('https://reqres.in/api/tasks/${task.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      )).thenAnswer((_) async => http.Response(json.encode(task.toJson()), 200));

      await taskService.updateTask(task);
      verify(client.put(
        Uri.parse('https://reqres.in/api/tasks/${task.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      )).called(1);
    });

    test('Delete Task', () async {
      when(client.delete(Uri.parse('https://reqres.in/api/tasks/1')))
          .thenAnswer((_) async => http.Response('', 204));

      await taskService.deleteTask('1');
      verify(client.delete(Uri.parse('https://reqres.in/api/tasks/1'))).called(1);
    });
  });
}
