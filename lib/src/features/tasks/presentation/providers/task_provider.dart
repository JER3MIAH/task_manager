import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/src/di.dart';
import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';
import 'package:task_manager/src/features/tasks/domain/repositories/repositories.dart';

final taskProvider = ChangeNotifierProvider<ChangeNotifier>((ref) {
  return sl<TaskNotifier>();
});

class TaskNotifier extends ChangeNotifier {
  final TaskRepository repository;
  TaskNotifier({required this.repository}) {
    getTasks();
  }

  List<Task> tasks = [];

  Future<void> getTasks() async {
    tasks = await repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    tasks.add(newTask);
    repository.addTask(newTask);
    notifyListeners();
  }

  Future<void> editTask(EditTaskRequest request) async {
    try {
      final index = tasks.indexWhere((task) => task.id == request.id);
      if (index != -1) {
        final oldTask = tasks[index];
        final newTask = Task(
          id: oldTask.id,
          createdAt: oldTask.createdAt,
          updatedAt: DateTime.now(),
          title: request.title ?? oldTask.title,
          description: request.description ?? oldTask.description,
          completed: request.completed ?? oldTask.completed,
          dueDate: request.dueDate ?? oldTask.dueDate,
          priority: request.priority ?? oldTask.priority,
        );
        tasks[index] = newTask;
        notifyListeners();
      }
    } catch (e, stack) {
      log('Error occured while editing: $e stack: $stack');
    }
  }

  Future<void> deleteTask(String taskId) async {
    tasks.removeWhere((task) => task.id == taskId);
    repository.deleteTask(taskId);
    notifyListeners();
  }
}
