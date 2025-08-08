import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';

class TaskLocalDatasource {
  final SharedPreferences prefs;

  TaskLocalDatasource({required this.prefs});

  Future<List<Task>> getTasks() async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');
      if (jsonList == null) return [];

      return jsonList.map((json) => Task.fromJson(json)).toList();
    } catch (e, stack) {
      log('error getting tasks: $e at $stack');
      return [];
    }
  }

  Future<void> createTask(Task task) async {
    try {
      List<String>? existingJsonList = prefs.getStringList('task_list');

      List<Task> existing = existingJsonList != null
          ? existingJsonList.map((json) => Task.fromJson((json))).toList()
          : [];

      if (!existing.any((b) => b.id == task.id)) {
        existing = [task, ...existing];
      }

      List<String> updatedJsonList = existing
          .map((task) => task.toJson())
          .toList();
      await prefs.setStringList('task_list', updatedJsonList);
    } catch (e, stack) {
      log('error creating task: $e at $stack');
    }
  }

  Future<void> editTask(EditTaskRequest request) async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');

      if (jsonList != null) {
        List<Task> existing = jsonList
            .map((json) => Task.fromJson(json))
            .toList();

        int index = existing.indexWhere((task) => task.id == request.id);

        if (index != -1) {
          final oldTask = existing[index];
          existing[index] = oldTask.copyWith(
            title: request.title ?? oldTask.title,
            description: request.description ?? oldTask.description,
            completed: request.completed ?? oldTask.completed,
            updatedAt: DateTime.now(),
            priority: request.priority ?? oldTask.priority,
            dueDate: request.dueDate ?? oldTask.dueDate,
          );
        }

        List<String> updatedJsonList = existing
            .map((task) => task.toJson())
            .toList();
        await prefs.setStringList('task_list', updatedJsonList);
      }
    } catch (e, stack) {
      log('error editing task: $e at $stack');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');

      if (jsonList != null) {
        List<Task> existing = jsonList
            .map((json) => Task.fromJson(json))
            .toList();

        existing.removeWhere((task) => task.id == id);

        List<String> updatedjsonList = existing
            .map((task) => task.toJson())
            .toList();
        await prefs.setStringList('task_list', updatedjsonList);
      }
    } catch (e, stack) {
      log('error removing task: $e at $stack');
    }
  }
}
