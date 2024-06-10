import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/data/apis_models/add_new_task_model.dart';
import 'package:task_manager_app/data/apis_models/get_all_tasks_model.dart';

class TaskService {
  final String baseUrl = 'https://reqres.in/api/tasks';
  final http.Client client;

  TaskService(this.client);

  Future<List<GetAllTasksModel>> fetchTasks() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((task) => GetAllTasksModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddNewTaskModel> createTask(AddNewTaskModel task) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return AddNewTaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(AddNewTaskModel task) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
